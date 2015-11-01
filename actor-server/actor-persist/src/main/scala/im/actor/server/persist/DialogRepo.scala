package im.actor.server.persist

import im.actor.server.models.{ Dialog, PeerType }
import slick.lifted.{ MappedProjection, ColumnOrdered }

import scala.concurrent.ExecutionContext

import com.github.tototoshi.slick.PostgresJodaSupport._
import org.joda.time.DateTime
import slick.dbio.Effect.{ Read, Write }
import slick.driver.PostgresDriver.api._
import slick.profile.{ SqlAction, FixedSqlStreamingAction, FixedSqlAction }

import im.actor.server.models

final case class DialogCommon(peer: models.Peer, lastMessageDate: DateTime, lastReceivedAt: DateTime, lastReadAt: DateTime)

final class DialogCommonTable(tag: Tag) extends Table[DialogCommon](tag, "dialogs") {
  def peerType = column[Int]("peer_type", O.PrimaryKey)

  def peerId = column[Int]("peer_id", O.PrimaryKey)

  def lastMessageDate = column[DateTime]("last_message_date")

  def lastReceivedAt = column[DateTime]("last_received_at")

  def lastReadAt = column[DateTime]("last_read_at")

  def * = (peerType, peerId, lastMessageDate, lastReceivedAt, lastReadAt) <> (applyDialogCommon.tupled, unapplyDialogCommon)

  def applyDialogCommon: (Int, Int, DateTime, DateTime, DateTime) ⇒ DialogCommon = {
    case (peerType, peerId, lastMessageDate, lastReceivedAt, lastReadAt) ⇒
      DialogCommon(models.Peer(models.PeerType.fromInt(peerType), peerId), lastMessageDate, lastReceivedAt, lastReadAt)
  }

  def unapplyDialogCommon: DialogCommon ⇒ Option[(Int, Int, DateTime, DateTime, DateTime)] = { common ⇒
    DialogCommon.unapply(common) map {
      case (peer, lastMessageDate, lastReceivedAt, lastReadAt) ⇒
        (peer.typ.toInt, peer.id, lastMessageDate, lastReceivedAt, lastReadAt)
    }
  }
}

case class UserDialog(
  userId:              Int,
  peer:                models.Peer,
  ownerLastReceivedAt: DateTime,
  ownerLastReadAt:     DateTime,
  isHidden:            Boolean,
  isArchived:          Boolean,
  createdAt:           DateTime
)

final class UserDialogTable(tag: Tag) extends Table[UserDialog](tag, "dialogs") {

  def userId = column[Int]("user_id", O.PrimaryKey)

  def peerType = column[Int]("peer_type", O.PrimaryKey)

  def peerId = column[Int]("peer_id", O.PrimaryKey)

  def lastMessageDate = column[DateTime]("last_message_date")

  def lastReceivedAt = column[DateTime]("last_received_at")

  def lastReadAt = column[DateTime]("last_read_at")

  def ownerLastReceivedAt = column[DateTime]("owner_last_received_at")

  def ownerLastReadAt = column[DateTime]("owner_last_read_at")

  def isHidden = column[Boolean]("is_hidden")

  def isArchived = column[Boolean]("is_archived")

  def createdAt = column[DateTime]("created_at")

  def * = (
    userId,
    peerType,
    peerId,
    ownerLastReceivedAt,
    ownerLastReadAt,
    isHidden,
    isArchived,
    createdAt
  ) <> (applyDialog.tupled, unapplyDialog)

  def applyDialog: (Int, Int, Int, DateTime, DateTime, Boolean, Boolean, DateTime) ⇒ UserDialog = {
    case (
      userId,
      peerType,
      peerId,
      ownerLastReceivedAt,
      ownerLastReadAt,
      isHidden,
      isArchived,
      createdAt) ⇒
      UserDialog(
        userId = userId,
        peer = models.Peer(models.PeerType.fromInt(peerType), peerId),
        ownerLastReceivedAt = ownerLastReceivedAt,
        ownerLastReadAt = ownerLastReadAt,
        isHidden = isHidden,
        isArchived = isArchived,
        createdAt = createdAt
      )
  }

  def unapplyDialog: UserDialog ⇒ Option[(Int, Int, Int, DateTime, DateTime, Boolean, Boolean, DateTime)] = { dialog ⇒
    UserDialog.unapply(dialog).map {
      case (userId, peer, ownerLastReceivedAt, ownerLastReadAt, isHidden, isArchived, createdAt) ⇒
        (userId, peer.typ.toInt, peer.id, ownerLastReceivedAt, ownerLastReadAt, isHidden, isArchived, createdAt)
    }
  }
}

object DialogRepo {
  private def applyDialog: (UserDialog, DialogCommon) ⇒ models.Dialog = {
    case (u, c) ⇒
      models.Dialog(
        userId = u.userId,
        peer = u.peer,
        lastMessageDate = c.lastMessageDate,
        lastReceivedAt = c.lastReceivedAt,
        lastReadAt = c.lastReadAt,
        ownerLastReceivedAt = u.ownerLastReceivedAt,
        ownerLastReadAt = u.ownerLastReadAt,
        isHidden = u.isHidden,
        isArchived = u.isArchived,
        createdAt = u.createdAt
      )
  }

  final case class LiftedD(
    userId:              Rep[Int],
    peerType:            Rep[Int],
    peerId:              Rep[Int],
    lastMessageDate:     Rep[DateTime],
    lastReceivedAt:      Rep[DateTime],
    lastReadAt:          Rep[DateTime],
    ownerLastReceivedAt: Rep[DateTime],
    ownerLastReadAt:     Rep[DateTime],
    isHidden:            Rep[Boolean],
    isArchived:          Rep[Boolean],
    createdAt:           Rep[DateTime]
  )

  object LiftedD {
    def build(tp: (UserDialogTable, DialogCommonTable)): LiftedD = {
      val (user, common) = tp
      LiftedD(
        userId = user.userId,
        peerType = user.peerType,
        peerId = user.peerId,
        lastMessageDate = common.lastMessageDate,
        lastReceivedAt = common.lastReceivedAt,
        lastReadAt = common.lastReadAt,
        ownerLastReceivedAt = user.ownerLastReceivedAt,
        ownerLastReadAt = user.ownerLastReadAt,
        isHidden = user.isHidden,
        isArchived = user.isArchived,
        createdAt = user.createdAt
      )
    }
  }

  implicit object DShape extends CaseClassShape(LiftedD.build, applyDialog.tupled)

  val userDialogs = TableQuery[UserDialogTable]
  val dialogsCommon = TableQuery[DialogCommonTable]

  val dialogs =
    (userDialogs join dialogsCommon on ((d, c) ⇒ d.peerType === c.peerType && d.peerId === c.peerId)) map {
      case (tp) ⇒ LiftedD.build(tp)
    }

  val dialogsC = Compiled(dialogs)

  def byPeerSimple(peerType: Rep[Int], peerId: Rep[Int]) =
    dialogs.filter(d ⇒ d.peerType === peerType && d.peerId === peerId)

  def byPKSimple(userId: Rep[Int], peerType: Rep[Int], peerId: Rep[Int]) =
    dialogs.filter(d ⇒ d.userId === userId && d.peerType === peerType && d.peerId === peerId)

  def byPK(userId: Int, peer: models.Peer) =
    byPKSimple(userId, peer.typ.toInt, peer.id)

  def byPeerType(userId: Rep[Int], peerType: Rep[Int]) =
    dialogs.filter(d ⇒ d.userId === userId && d.peerType === peerType)

  def idByPeerType(userId: Rep[Int], peerType: Rep[Int]) =
    byPeerType(userId, peerType).map(_.peerId)

  def userIdByPeerType(peerType: Rep[Int], peerId: Rep[Int]) =
    byPeerSimple(peerType, peerId)

  val byPKC = Compiled(byPKSimple _)
  val byPeerC = Compiled(byPeerSimple _)
  val byPeerTypeC = Compiled(byPeerType _)
  val idByPeerTypeC = Compiled(idByPeerType _)

  val notArchived = DialogRepo.dialogs joinLeft GroupRepo.groups on (_.peerId === _.id) filter {
    case (dialog, groupOpt) ⇒ dialog.isArchived === false && groupOpt.map(!_.isHidden).getOrElse(true)
  } map (_._1)

  val notHiddenNotArchived = notArchived filter (_.isHidden === false)

  def create(dialog: models.Dialog) =
    dialogsC += dialog

  def create(dialogs: Seq[models.Dialog]) =
    dialogsC ++= dialogs

  def createIfNotExists(dialog: models.Dialog)(implicit ec: ExecutionContext): DBIO[Boolean] = {
    for {
      dOpt ← find(dialog.userId, dialog.peer)
      res ← if (dOpt.isEmpty) create(dialog).map(_ ⇒ true) else DBIO.successful(false)
    } yield res
  }

  def find(userId: Int, peer: models.Peer): SqlAction[Option[models.Dialog], NoStream, Read] =
    byPKC((userId, peer.typ.toInt, peer.id)).result.headOption

  def findGroups(userId: Int): FixedSqlStreamingAction[Seq[models.Dialog], models.Dialog, Read] =
    byPeerTypeC((userId, models.PeerType.Group.toInt)).result

  def findAllGroups(userIds: Set[Int], groupId: Int) =
    dialogs.filter(d ⇒ d.peerType === PeerType.Group.toInt && d.peerId === groupId && d.userId.inSet(userIds)).result

  def findGroupIds(userId: Int): FixedSqlStreamingAction[Seq[Int], Int, Read] =
    idByPeerTypeC((userId, models.PeerType.Group.toInt)).result

  def findUserIds(userId: Int): FixedSqlStreamingAction[Seq[Int], Int, Read] =
    idByPeerTypeC((userId, models.PeerType.Private.toInt)).result

  def findLastReadBefore(date: DateTime, userId: Int) =
    dialogs.filter(d ⇒ d.userId === userId && d.ownerLastReadAt < date).result

  def findNotArchivedSortByCreatedAt(userId: Int, dateOpt: Option[DateTime], limit: Int, fetchHidden: Boolean = false)(implicit ec: ExecutionContext): DBIO[Seq[models.Dialog]] =
    findNotArchived(userId, dateOpt: Option[DateTime], limit, _.createdAt.asc, fetchHidden)

  def findNotArchived(userId: Int, dateOpt: Option[DateTime], limit: Int, fetchHidden: Boolean = false)(implicit ec: ExecutionContext): DBIO[Seq[models.Dialog]] =
    findNotArchived(userId, dateOpt: Option[DateTime], limit, _.lastMessageDate.desc, fetchHidden)

  def findNotArchived[A](userId: Int, dateOpt: Option[DateTime], limit: Int, sortBy: LiftedD ⇒ ColumnOrdered[A], fetchHidden: Boolean)(implicit ec: ExecutionContext): DBIO[Seq[models.Dialog]] = {
    val baseQuery = (if (fetchHidden) notArchived else notHiddenNotArchived)
      .filter(d ⇒ d.userId === userId)
      .sortBy(sortBy)

    val limitedQuery = dateOpt match {
      case Some(date) ⇒ baseQuery.filter(_.lastMessageDate <= date)
      case None       ⇒ baseQuery
    }

    for {
      limited ← limitedQuery.take(limit).result
      // work-around for case when there are more than one dialog with the same lastMessageDate
      result ← limited
        .lastOption match {
          case Some(last) ⇒
            for {
              sameDate ← baseQuery.filter(_.lastMessageDate === last.lastMessageDate).result
            } yield limited.filterNot(_.lastMessageDate == last.lastMessageDate) ++ sameDate
          case None ⇒ DBIO.successful(limited)
        }
    } yield result
  }

  def hide(userId: Int, peer: models.Peer) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.isHidden).update(false)

  def show(userId: Int, peer: models.Peer) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.isHidden).update(true)

  def updateLastMessageDate(userId: Int, peer: models.Peer, lastMessageDate: DateTime)(implicit ec: ExecutionContext) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.lastMessageDate).update(lastMessageDate)

  def findExistingUserIds(userIds: Set[Int], peer: models.Peer): FixedSqlStreamingAction[Seq[Int], Int, Read] = {
    byPeerC.applied((peer.typ.toInt, peer.id))
      .filter(_.userId inSetBind userIds)
      .map(_.userId)
      .result
  }

  def updateLastMessageDates(userIds: Set[Int], peer: models.Peer, lastMessageDate: DateTime)(implicit ec: ExecutionContext) = {
    byPeerC.applied((peer.typ.toInt, peer.id))
      .filter(_.userId inSetBind userIds)
      .map(_.lastMessageDate)
      .update(lastMessageDate)
  }

  def updateLastReceivedAt(userId: Int, peer: models.Peer, lastReceivedAt: DateTime)(implicit ec: ExecutionContext) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.lastReceivedAt).update(lastReceivedAt)

  def updateLastReceivedAt(userIds: Set[Int], peer: models.Peer, lastReceivedAt: DateTime)(implicit ec: ExecutionContext) = {
    byPeerC.applied((peer.typ.toInt, peer.id))
      .filter(_.userId inSetBind userIds)
      .map(_.lastReceivedAt)
      .update(lastReceivedAt)
  }

  def updateOwnerLastReceivedAt(userId: Int, peer: models.Peer, ownerLastReceivedAt: DateTime)(implicit ec: ExecutionContext) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.ownerLastReceivedAt).update(ownerLastReceivedAt)

  def updateLastReadAt(userId: Int, peer: models.Peer, lastReadAt: DateTime)(implicit ec: ExecutionContext) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.lastReadAt).update(lastReadAt)

  def updateLastReadAt(userIds: Set[Int], peer: models.Peer, lastReadAt: DateTime)(implicit ec: ExecutionContext) = {
    byPeerC.applied((peer.typ.toInt, peer.id))
      .filter(_.userId inSetBind userIds)
      .map(_.lastReadAt)
      .update(lastReadAt)
  }

  def updateOwnerLastReadAt(userId: Int, peer: models.Peer, ownerLastReadAt: DateTime)(implicit ec: ExecutionContext) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.ownerLastReadAt).update(ownerLastReadAt)

  def makeArchived(userId: Int, peer: models.Peer) =
    byPKC.applied((userId, peer.typ.toInt, peer.id)).map(_.isArchived).update(true)

  def delete(userId: Int, peer: models.Peer): FixedSqlAction[Int, NoStream, Write] =
    userDialogs
      .filter(d ⇒ d.userId === userId && d.peerType === peer.typ.toInt && d.peerId === peer.id)
      .delete
}
