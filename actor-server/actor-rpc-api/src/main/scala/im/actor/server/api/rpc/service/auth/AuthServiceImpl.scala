package im.actor.server.api.rpc.service.auth

import java.time.{ LocalDateTime, ZoneOffset }

import akka.actor.{ ActorRef, ActorSystem }
import akka.cluster.pubsub.DistributedPubSub
import akka.event.Logging
import akka.util.Timeout
import im.actor.api.rpc.DBIOResult._
import im.actor.api.rpc._
import im.actor.api.rpc.auth.ApiEmailActivationType._
import im.actor.api.rpc.auth._
import im.actor.api.rpc.misc._
import im.actor.api.rpc.users.ApiSex.ApiSex
import im.actor.server.acl.ACLUtils
import im.actor.server.activation.{ CodeFailure, CodeActivation }
import im.actor.server.auth.DeviceInfo
import im.actor.server.db.DbExtension
import im.actor.server.oauth.{ GoogleProvider, OAuth2ProvidersDomains }
import im.actor.server.persist.auth.AuthTransactionRepo
import im.actor.server.session._
import im.actor.server.social.{ SocialExtension, SocialManagerRegion }
import im.actor.server.user.UserExtension
import im.actor.server.{ model, persist }
import im.actor.util.log.AnyRefLogSource
import im.actor.util.misc.PhoneNumberUtils._
import im.actor.util.misc._
import org.joda.time.DateTime
import shapeless._
import slick.dbio.DBIO
import slick.driver.PostgresDriver.api._

import scala.concurrent._
import scala.concurrent.duration._
import scala.concurrent.forkjoin.ThreadLocalRandom
import scala.language.postfixOps
import scalaz._

class AuthServiceImpl(val activationContext: CodeActivation)(
  implicit
  val sessionRegion: SessionRegion,
  val actorSystem:   ActorSystem,
  val oauth2Service: GoogleProvider
) extends AuthService with AuthHelpers with Helpers {

  import AnyRefLogSource._
  import IdUtils._

  private trait SignType
  private case class Up(name: String, isSilent: Boolean) extends SignType
  private case object In extends SignType

  override implicit val ec: ExecutionContext = actorSystem.dispatcher

  protected implicit val db: Database = DbExtension(actorSystem).db
  protected val userExt = UserExtension(actorSystem)
  protected implicit val socialRegion: SocialManagerRegion = SocialExtension(actorSystem).region

  protected val log = Logging(actorSystem, this)

  private val maxGroupSize: Int = 300

  implicit protected val timeout = Timeout(10 seconds)

  override def jhandleGetAuthSessions(clientData: ClientData): Future[HandlerResult[ResponseGetAuthSessions]] = {
    val authorizedAction = requireAuth(clientData).map { client ⇒
      for {
        sessionModels ← persist.AuthSessionRepo.findByUserId(client.userId)
      } yield {
        val sessionStructs = sessionModels map { sessionModel ⇒
          val authHolder =
            if (client.authId == sessionModel.authId) {
              ApiAuthHolder.ThisDevice
            } else {
              ApiAuthHolder.OtherDevice
            }

          ApiAuthSession(
            sessionModel.id,
            authHolder,
            sessionModel.appId,
            sessionModel.appTitle,
            sessionModel.deviceTitle,
            (sessionModel.authTime.getMillis / 1000).toInt,
            sessionModel.authLocation,
            sessionModel.latitude,
            sessionModel.longitude
          )
        }

        Ok(ResponseGetAuthSessions(sessionStructs.toVector))
      }
    }

    db.run(toDBIOAction(authorizedAction))
  }

  def jhandleCompleteOAuth2(transactionHash: String, code: String, clientData: ClientData): Future[HandlerResult[ResponseAuth]] = {
    val action: Result[ResponseAuth] =
      for {
        transaction ← fromDBIOOption(AuthErrors.EmailCodeExpired)(persist.auth.AuthEmailTransactionRepo.find(transactionHash))
        token ← fromDBIOOption(AuthErrors.EmailCodeExpired)(oauth2Service.completeOAuth(code, transaction.email, transaction.redirectUri))
        profile ← fromFutureOption(AuthErrors.EmailCodeExpired)(oauth2Service.fetchProfile(token.accessToken))

        _ ← fromBoolean(AuthErrors.OAuthUserIdDoesNotMatch)(transaction.email == profile.email)
        _ ← fromDBIO(persist.OAuth2TokenRepo.createOrUpdate(token))

        _ ← fromDBIO(AuthTransactionRepo.updateSetChecked(transactionHash))

        email ← fromDBIOOption(AuthErrors.EmailUnoccupied)(persist.UserEmailRepo.find(transaction.email))

        user ← authorizeT(email.userId, profile.locale.getOrElse(""), DeviceInfo.parseFrom(transaction.deviceInfo), clientData)
        userStruct ← fromFuture(userExt.getApiStruct(user.id, user.id, clientData.authId))

        //refresh session data
        authSession = model.AuthSession(
          userId = user.id,
          id = nextIntId(ThreadLocalRandom.current()),
          authId = clientData.authId,
          appId = transaction.appId,
          appTitle = model.AuthSession.appTitleOf(transaction.appId),
          deviceHash = transaction.deviceHash,
          deviceTitle = transaction.deviceTitle,
          authTime = DateTime.now,
          authLocation = "",
          latitude = None,
          longitude = None
        )
        _ ← fromDBIO(refreshAuthSession(transaction.deviceHash, authSession))
        _ ← fromDBIO(persist.auth.AuthTransactionRepo.delete(transactionHash))
        ack ← fromFuture(authorize(user.id, clientData))
      } yield ResponseAuth(userStruct, misc.ApiConfig(maxGroupSize))
    db.run(action.run)
  }

  def jhandleGetOAuth2Params(transactionHash: String, redirectUrl: String, clientData: ClientData): Future[HandlerResult[ResponseGetOAuth2Params]] = {
    val action =
      for {
        transaction ← fromDBIOOption(AuthErrors.EmailCodeExpired)(persist.auth.AuthEmailTransactionRepo.find(transactionHash))
        url ← fromOption(AuthErrors.RedirectUrlInvalid)(oauth2Service.getAuthUrl(redirectUrl, transaction.email))
        _ ← fromDBIO(persist.auth.AuthEmailTransactionRepo.updateRedirectUri(transaction.transactionHash, redirectUrl))
      } yield ResponseGetOAuth2Params(url)
    db.run(action.run)
  }

  def jhandleStartPhoneAuth(
    phoneNumber:        Long,
    appId:              Int,
    apiKey:             String,
    deviceHash:         Array[Byte],
    deviceTitle:        String,
    timeZone:           Option[String],
    preferredLanguages: IndexedSeq[String],
    clientData:         ClientData
  ): Future[HandlerResult[ResponseStartPhoneAuth]] = {
    val action = for {
      normalizedPhone ← fromOption(AuthErrors.PhoneNumberInvalid)(normalizeLong(phoneNumber).headOption)
      optAuthTransaction ← fromDBIO(persist.auth.AuthPhoneTransactionRepo.findByPhoneAndDeviceHash(normalizedPhone, deviceHash))
      transactionHash ← optAuthTransaction match {
        case Some(transaction) ⇒ point(transaction.transactionHash)
        case None ⇒
          val accessSalt = ACLUtils.nextAccessSalt()
          val transactionHash = ACLUtils.authTransactionHash(accessSalt)
          val phoneAuthTransaction = model.AuthPhoneTransaction(
            normalizedPhone,
            transactionHash,
            appId,
            apiKey,
            deviceHash,
            deviceTitle,
            accessSalt,
            DeviceInfo(timeZone.getOrElse(""), preferredLanguages).toByteArray
          )
          for {
            _ ← fromDBIO(persist.auth.AuthPhoneTransactionRepo.create(phoneAuthTransaction))
          } yield transactionHash
      }
      _ ← fromDBIOEither[Unit, CodeFailure](AuthErrors.activationFailure)(sendSmsCode(normalizedPhone, genSmsCode(normalizedPhone), Some(transactionHash)))
      isRegistered ← fromDBIO(persist.UserPhoneRepo.exists(normalizedPhone))
    } yield ResponseStartPhoneAuth(transactionHash, isRegistered)
    db.run(action.run)
  }

  override def jhandleSendCodeByPhoneCall(transactionHash: String, clientData: ClientData): Future[HandlerResult[ResponseVoid]] = {
    val action = for {
      tx ← fromDBIOOption(AuthErrors.PhoneCodeExpired)(persist.auth.AuthPhoneTransactionRepo.find(transactionHash))
      code ← fromDBIO(persist.AuthCodeRepo.findByTransactionHash(tx.transactionHash) map (_ map (_.code) getOrElse (genSmsCode(tx.phoneNumber))))
      lang = PhoneNumberUtils.normalizeWithCountry(tx.phoneNumber).headOption.map(_._2).getOrElse("en")
      _ ← fromDBIOEither[Unit, CodeFailure](AuthErrors.activationFailure)(sendCallCode(tx.phoneNumber, genSmsCode(tx.phoneNumber), Some(transactionHash), lang))
    } yield ResponseVoid

    db.run(action.run)
  }

  def jhandleSignUp(transactionHash: String, name: String, sex: Option[ApiSex], clientData: ClientData): Future[HandlerResult[ResponseAuth]] = {
    val action: Result[ResponseAuth] =
      for {
        //retrieve `authTransaction`
        transaction ← fromDBIOOption(AuthErrors.PhoneCodeExpired)(persist.auth.AuthTransactionRepo.findChildren(transactionHash))
        //ensure that `authTransaction` is checked
        _ ← fromBoolean(AuthErrors.NotValidated)(transaction.isChecked)
        signInORsignUp ← transaction match {
          case p: model.AuthPhoneTransaction ⇒ newUserPhoneSignUp(p, name, sex)
          case e: model.AuthEmailTransaction ⇒ newUserEmailSignUp(e, name, sex)
        }
        //fallback to sign up if user exists
        user ← signInORsignUp match {
          case -\/((userId, countryCode)) ⇒ authorizeT(userId, countryCode, DeviceInfo.parseFrom(transaction.deviceInfo), clientData)
          case \/-(user)                  ⇒ handleUserCreate(user, transaction)
        }
        userStruct ← fromFuture(userExt.getApiStruct(user.id, user.id, clientData.authId))
        //refresh session data
        authSession = model.AuthSession(
          userId = user.id,
          id = nextIntId(ThreadLocalRandom.current()),
          authId = clientData.authId,
          appId = transaction.appId,
          appTitle = model.AuthSession.appTitleOf(transaction.appId),
          deviceHash = transaction.deviceHash,
          deviceTitle = transaction.deviceTitle,
          authTime = DateTime.now,
          authLocation = "",
          latitude = None,
          longitude = None
        )
        _ ← fromDBIO(refreshAuthSession(transaction.deviceHash, authSession))
        ack ← fromFuture(authorize(user.id, clientData))
      } yield ResponseAuth(userStruct, misc.ApiConfig(maxGroupSize))
    db.run(action.run)
  }

  override def jhandleStartEmailAuth(
    email:              String,
    appId:              Int,
    apiKey:             String,
    deviceHash:         Array[Byte],
    deviceTitle:        String,
    timeZone:           Option[String],
    preferredLanguages: IndexedSeq[String],
    clientData:         ClientData
  ): Future[HandlerResult[ResponseStartEmailAuth]] = {
    val action = for {
      validEmail ← fromEither(validEmail(email).leftMap(validationFailed("EMAIL_INVALID", _)))
      //    OAUTH activation is temporary disabled
      //    activationType = if (OAuth2ProvidersDomains.supportsOAuth2(validEmail)) OAUTH2 else CODE
      activationType = CODE
      isRegistered ← fromDBIO(persist.UserEmailRepo.exists(validEmail))
      optTransaction ← fromDBIO(persist.auth.AuthEmailTransactionRepo.findByEmailAndDeviceHash(validEmail, deviceHash))
      transactionHash ← optTransaction match {
        case Some(trans) ⇒
          val hash = trans.transactionHash
          activationType match {
            case CODE ⇒
              for {
                _ ← fromDBIOEither[Unit, CodeFailure](AuthErrors.activationFailure)(sendEmailCode(validEmail, genEmailCode(validEmail), hash))
              } yield hash
            case OAUTH2 ⇒
              point(hash)
          }
        case None ⇒
          val accessSalt = ACLUtils.nextAccessSalt()
          val transactionHash = ACLUtils.authTransactionHash(accessSalt)
          val emailAuthTransaction = model.AuthEmailTransaction(
            validEmail,
            None,
            transactionHash,
            appId,
            apiKey,
            deviceHash,
            deviceTitle,
            accessSalt,
            DeviceInfo(timeZone.getOrElse(""), preferredLanguages).toByteArray
          )
          activationType match {
            case CODE ⇒
              for {
                _ ← fromDBIO(persist.auth.AuthEmailTransactionRepo.create(emailAuthTransaction))
                _ ← fromDBIOEither[Unit, CodeFailure](AuthErrors.activationFailure)(sendEmailCode(validEmail, genEmailCode(validEmail), transactionHash))
              } yield transactionHash
            case OAUTH2 ⇒
              for {
                _ ← fromDBIO(persist.auth.AuthEmailTransactionRepo.create(emailAuthTransaction))
              } yield transactionHash
          }
      }
    } yield ResponseStartEmailAuth(transactionHash, isRegistered, activationType)
    db.run(action.run)
  }

  //TODO: add email code validation
  def jhandleValidateCode(transactionHash: String, code: String, clientData: ClientData): Future[HandlerResult[ResponseAuth]] = {
    val action: Result[ResponseAuth] =
      for {
        //retreive `authTransaction`
        transaction ← fromDBIOOption(AuthErrors.PhoneCodeExpired)(persist.auth.AuthTransactionRepo.findChildren(transactionHash))

        //validate code
        userAndCounty ← validateCode(transaction, code)
        (userId, countryCode) = userAndCounty

        //sign in user and delete auth transaction
        user ← authorizeT(userId, countryCode, DeviceInfo.parseFrom(transaction.deviceInfo), clientData)
        userStruct ← fromFuture(userExt.getApiStruct(user.id, user.id, clientData.authId))
        _ ← fromDBIO(persist.auth.AuthTransactionRepo.delete(transaction.transactionHash))

        //refresh session data
        authSession = model.AuthSession(
          userId = user.id,
          id = nextIntId(ThreadLocalRandom.current()),
          authId = clientData.authId,
          appId = transaction.appId,
          appTitle = model.AuthSession.appTitleOf(transaction.appId),
          deviceHash = transaction.deviceHash,
          deviceTitle = transaction.deviceTitle,
          authTime = DateTime.now,
          authLocation = "",
          latitude = None,
          longitude = None
        )
        _ ← fromDBIO(refreshAuthSession(transaction.deviceHash, authSession))
        ack ← fromFuture(authorize(user.id, clientData))
      } yield ResponseAuth(userStruct, misc.ApiConfig(maxGroupSize))
    db.run(action.run)
  }

  override def jhandleSignOut(clientData: ClientData): Future[HandlerResult[ResponseVoid]] = {
    val action = requireAuth(clientData) map { implicit client ⇒
      persist.AuthSessionRepo.findByAuthId(client.authId) flatMap {
        case Some(session) ⇒
          for (_ ← DBIO.from(userExt.logout(session))) yield Ok(misc.ResponseVoid)
        case None ⇒ throw new Exception(s"Cannot find AuthSession for authId: ${client.authId}")
      }
    }

    db.run(toDBIOAction(action))
  }

  override def jhandleTerminateAllSessions(clientData: ClientData): Future[HandlerResult[ResponseVoid]] = {
    val authorizedAction = requireAuth(clientData).map { client ⇒
      for {
        sessions ← persist.AuthSessionRepo.findByUserId(client.userId) map (_.filterNot(_.authId == client.authId))
        _ ← DBIO.from(Future.sequence(sessions map userExt.logout))
      } yield {
        Ok(ResponseVoid)
      }
    }

    db.run(toDBIOAction(authorizedAction))
  }

  override def jhandleTerminateSession(id: Int, clientData: ClientData): Future[HandlerResult[ResponseVoid]] = {
    val authorizedAction = requireAuth(clientData).map { client ⇒
      persist.AuthSessionRepo.find(client.userId, id).headOption flatMap {
        case Some(session) ⇒
          if (session.authId != clientData.authId) {
            for (_ ← DBIO.from(userExt.logout(session))) yield Ok(ResponseVoid)
          } else {
            DBIO.successful(Error(AuthErrors.CurrentSessionTermination))
          }
        case None ⇒
          DBIO.successful(Error(AuthErrors.AuthSessionNotFound))
      }

    }

    db.run(toDBIOAction(authorizedAction))
  }

  override def jhandleStartAnonymousAuth(name: String, clientData: ClientData): Future[HandlerResult[ResponseAuth]] = throw new Exception("Not implemented")

  override def jhandleStartTokenAuth(token: String, clientData: ClientData): Future[HandlerResult[ResponseAuth]] = throw new Exception("Not implemented")

  override def jhandleValidatePassword(transactionHash: String, password: String, clientData: ClientData): Future[HandlerResult[ResponseAuth]] = throw new Exception("Not implemented")

  //TODO: move deprecated methods to separate trait
  @deprecated("schema api changes", "2015-06-09")
  override def jhandleSendAuthCallObsolete(
    phoneNumber: Long,
    smsHash:     String,
    appId:       Int,
    apiKey:      String,
    clientData:  ClientData
  ): Future[HandlerResult[ResponseVoid]] =
    Future {
      throw new Exception("Not implemented")
    }

  @deprecated("schema api changes", "2015-06-09")
  override def jhandleSendAuthCodeObsolete(
    rawPhoneNumber: Long,
    appId:          Int,
    apiKey:         String,
    clientData:     ClientData
  ): Future[HandlerResult[ResponseSendAuthCodeObsolete]] = {
    PhoneNumberUtils.normalizeLong(rawPhoneNumber).headOption match {
      case None ⇒
        Future.successful(Error(AuthErrors.PhoneNumberInvalid))
      case Some(normPhoneNumber) ⇒
        val action = persist.AuthSmsCodeObsoleteRepo.findByPhoneNumber(normPhoneNumber).headOption.flatMap {
          case Some(model.AuthSmsCodeObsolete(_, _, smsHash, smsCode, _)) ⇒
            DBIO.successful(normPhoneNumber :: smsHash :: smsCode :: HNil)
          case None ⇒
            val smsHash = genSmsHash()
            val smsCode = genSmsCode(normPhoneNumber)
            for (
              _ ← persist.AuthSmsCodeObsoleteRepo.create(
                id = ThreadLocalRandom.current().nextLong(),
                phoneNumber = normPhoneNumber,
                smsHash = smsHash,
                smsCode = smsCode
              )
            ) yield normPhoneNumber :: smsHash :: smsCode :: HNil
        }.flatMap { res ⇒
          persist.UserPhoneRepo.exists(normPhoneNumber) map (res :+ _)
        }.map {
          case number :: smsHash :: smsCode :: isRegistered :: HNil ⇒
            sendSmsCode(number, smsCode, None)
            Ok(ResponseSendAuthCodeObsolete(smsHash, isRegistered))
        }
        db.run(action)
    }
  }

  @deprecated("schema api changes", "2015-06-09")
  override def jhandleSignInObsolete(
    rawPhoneNumber: Long,
    smsHash:        String,
    smsCode:        String,
    deviceHash:     Array[Byte],
    deviceTitle:    String,
    appId:          Int,
    appKey:         String,
    clientData:     ClientData
  ): Future[HandlerResult[ResponseAuth]] =
    handleSign(
      In,
      rawPhoneNumber, smsHash, smsCode,
      deviceHash, deviceTitle, appId, appKey,
      clientData
    )

  @deprecated("schema api changes", "2015-06-09")
  override def jhandleSignUpObsolete(
    rawPhoneNumber: Long,
    smsHash:        String,
    smsCode:        String,
    name:           String,
    deviceHash:     Array[Byte],
    deviceTitle:    String,
    appId:          Int,
    appKey:         String,
    isSilent:       Boolean,
    clientData:     ClientData
  ): Future[HandlerResult[ResponseAuth]] =
    handleSign(
      Up(name, isSilent),
      rawPhoneNumber, smsHash, smsCode,
      deviceHash, deviceTitle, appId, appKey,
      clientData
    )

  private def handleSign(
    signType:       SignType,
    rawPhoneNumber: Long,
    smsHash:        String,
    smsCode:        String,
    deviceHash:     Array[Byte],
    deviceTitle:    String,
    appId:          Int,
    appKey:         String,
    clientData:     ClientData
  ): Future[HandlerResult[ResponseAuth]] = {
    normalizeWithCountry(rawPhoneNumber).headOption match {
      case None ⇒ Future.successful(Error(AuthErrors.PhoneNumberInvalid))
      case Some((normPhoneNumber, countryCode)) ⇒
        if (smsCode.isEmpty) Future.successful(Error(AuthErrors.PhoneCodeEmpty))
        else {
          val action =
            (for {
              optCode ← persist.AuthSmsCodeObsoleteRepo.findByPhoneNumber(normPhoneNumber).headOption
              optPhone ← persist.UserPhoneRepo.findByPhoneNumber(normPhoneNumber).headOption
            } yield optCode :: optPhone :: HNil).flatMap {
              case None :: _ :: HNil ⇒ DBIO.successful(Error(AuthErrors.PhoneCodeExpired))
              case Some(smsCodeModel) :: _ :: HNil if smsCodeModel.smsHash != smsHash ⇒
                DBIO.successful(Error(AuthErrors.PhoneCodeExpired))
              case Some(smsCodeModel) :: _ :: HNil if smsCodeModel.smsCode != smsCode ⇒
                DBIO.successful(Error(AuthErrors.PhoneCodeInvalid))
              case Some(_) :: optPhone :: HNil ⇒
                signType match {
                  case Up(rawName, isSilent) ⇒
                    persist.AuthSmsCodeObsoleteRepo.deleteByPhoneNumber(normPhoneNumber).andThen(
                      optPhone match {
                        // Phone does not exist, register the user
                        case None ⇒ withValidName(rawName) { name ⇒
                          val rnd = ThreadLocalRandom.current()
                          val userId = nextIntId(rnd)
                          //todo: move this to UserOffice
                          val user = model.User(
                            id = userId,
                            accessSalt = ACLUtils.nextAccessSalt(rnd),
                            name = name,
                            countryCode = countryCode,
                            sex = model.NoSex,
                            state = model.UserState.Registered,
                            createdAt = LocalDateTime.now(ZoneOffset.UTC),
                            external = None
                          )
                          for {
                            _ ← DBIO.from(userExt.create(user.id, user.accessSalt, None, user.name, user.countryCode, im.actor.api.rpc.users.ApiSex(user.sex.toInt), isBot = false))
                            _ ← DBIO.from(userExt.auth(userId, clientData.authId))
                            _ ← DBIO.from(userExt.addPhone(user.id, normPhoneNumber))
                            _ ← persist.AvatarDataRepo.create(model.AvatarData.empty(model.AvatarData.OfUser, user.id.toLong))
                          } yield {
                            \/-(user :: HNil)
                          }
                        }
                        // Phone already exists, fall back to SignIn
                        case Some(phone) ⇒
                          signIn(clientData.authId, phone.userId, countryCode, clientData)
                      }
                    )
                  case In ⇒
                    optPhone match {
                      case None ⇒ DBIO.successful(Error(AuthErrors.PhoneNumberUnoccupied))
                      case Some(phone) ⇒
                        persist.AuthSmsCodeObsoleteRepo.deleteByPhoneNumber(normPhoneNumber).andThen(
                          signIn(clientData.authId, phone.userId, countryCode, clientData)
                        )
                    }
                }
            }.flatMap {
              case \/-(user :: HNil) ⇒
                val rnd = ThreadLocalRandom.current()
                val authSession = model.AuthSession(
                  userId = user.id,
                  id = nextIntId(rnd),
                  authId = clientData.authId,
                  appId = appId,
                  appTitle = model.AuthSession.appTitleOf(appId),
                  deviceHash = deviceHash,
                  deviceTitle = deviceTitle,
                  authTime = DateTime.now,
                  authLocation = "",
                  latitude = None,
                  longitude = None
                )

                for {
                  prevSessions ← persist.AuthSessionRepo.findByDeviceHash(deviceHash)
                  _ ← DBIO.from(Future.sequence(prevSessions map userExt.logout))
                  _ ← persist.AuthSessionRepo.create(authSession)
                  userStruct ← DBIO.from(userExt.getApiStruct(user.id, user.id, clientData.authId))
                } yield {
                  sessionRegion.ref ! SessionEnvelope(clientData.authId, clientData.sessionId).withAuthorizeUser(AuthorizeUser(userStruct.id, authSession.id))
                  Ok(
                    ResponseAuth(
                      userStruct,
                      misc.ApiConfig(maxGroupSize)
                    )
                  )

                }
              case error @ -\/(_) ⇒ DBIO.successful(error)
            }

          db.run(action)
        }
    }
  }

  private def signIn(authId: Long, userId: Int, countryCode: String, clientData: ClientData) = {
    persist.UserRepo.find(userId).headOption.flatMap {
      case None ⇒ throw new Exception("Failed to retrieve user")
      case Some(user) ⇒
        for {
          _ ← DBIO.from(userExt.changeCountryCode(userId, countryCode))
          _ ← DBIO.from(userExt.auth(userId, clientData.authId))
        } yield \/-(user :: HNil)
    }
  }

}
