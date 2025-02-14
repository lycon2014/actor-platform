package im.actor.server.api.rpc.service.messaging

import akka.actor._
import akka.cluster.pubsub.{ DistributedPubSub, DistributedPubSubMediator }
import im.actor.api.rpc.Implicits._
import im.actor.api.rpc.messaging._
import im.actor.api.rpc.peers.{ ApiPeer, ApiPeerType }
import im.actor.server.db.DbExtension
import im.actor.server.dialog.DialogExtension
import im.actor.server.group.GroupExtension
import im.actor.server.model
import im.actor.server.social.{ SocialExtension, SocialManagerRegion }
import im.actor.server.user.UserExtension
import slick.driver.PostgresDriver.api._

sealed trait Event

object Events {

  final case class PeerMessage(fromPeer: model.Peer, toPeer: model.Peer, randomId: Long, date: Long, message: ApiMessage) extends Event

}

object MessagingService {
  val privateMessagesTopic: String = "messaging.messages.private"
  val groupMessagesTopic: String = "messaging.messages.group"

  def messagesTopic(peer: model.Peer): String = {
    val strType = peer.typ match {
      case model.PeerType.Private ⇒ "private"
      case model.PeerType.Group   ⇒ "group"
      case _                      ⇒ throw new RuntimeException(s"Unknown peer type ${peer.typ}")
    }

    s"messaging.messages.$strType.${peer.id}"
  }

  def messagesTopic(peer: ApiPeer): String =
    messagesTopic(peer.asModel)

  def publish(mediator: ActorRef, message: Events.PeerMessage): Unit = {
    message.toPeer.typ match {
      case model.PeerType.Private ⇒
        val senderTopic = MessagingService.messagesTopic(ApiPeer(ApiPeerType.Private, message.fromPeer.id))
        val receiverTopic = messagesTopic(message.toPeer)

        mediator ! DistributedPubSubMediator.Publish(privateMessagesTopic, message, sendOneMessageToEachGroup = true)
        mediator ! DistributedPubSubMediator.Publish(senderTopic, message, sendOneMessageToEachGroup = true)
        mediator ! DistributedPubSubMediator.Publish(receiverTopic, message, sendOneMessageToEachGroup = true)
      case model.PeerType.Group ⇒
        val topic = messagesTopic(message.toPeer)

        mediator ! DistributedPubSubMediator.Publish(groupMessagesTopic, message, sendOneMessageToEachGroup = false)
        mediator ! DistributedPubSubMediator.Publish(topic, message, sendOneMessageToEachGroup = false)
      case unknown ⇒ throw new RuntimeException(s"Unknown peer type $unknown")
    }
  }
}

object MessagingServiceImpl {
  def apply()(
    implicit
    actorSystem: ActorSystem
  ): MessagingServiceImpl = {
    val onMessage = (MessagingService.publish _).curried(DistributedPubSub(actorSystem).mediator)

    new MessagingServiceImpl(onMessage)
  }
}

final class MessagingServiceImpl(
  protected val onMessage: Events.PeerMessage ⇒ Unit
)(
  implicit
  protected val actorSystem: ActorSystem
) extends MessagingService with MessagingHandlers with HistoryHandlers with ReactionsHandlers with FavouritesHandlers {
  protected val db: Database = DbExtension(actorSystem).db
  protected val userExt = UserExtension(actorSystem)
  protected val groupExt = GroupExtension(actorSystem)
  protected val dialogExt = DialogExtension(actorSystem)
  protected implicit val socialRegion: SocialManagerRegion = SocialExtension(actorSystem).region

}
