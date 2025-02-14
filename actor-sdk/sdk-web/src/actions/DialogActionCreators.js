/*
 * Copyright (C) 2015 Actor LLC. <https://actor.im>
 */

import { dispatch, dispatchAsync } from '../dispatcher/ActorAppDispatcher';
import { ActionTypes, PeerTypes } from '../constants/ActorAppConstants';
import ActorClient from '../utils/ActorClient';
import PeerUtils from '../utils/PeerUtils';
import RouterContainer from '../utils/RouterContainer';
import MessageActionCreators from './MessageActionCreators';
import GroupProfileActionCreators from './GroupProfileActionCreators';
import DialogStore from '../stores/DialogStore';

const DialogActionCreators = {
  setDialogs(dialogs) {
    dispatch(ActionTypes.DIALOGS_CHANGED, { dialogs });
  },

  selectDialogPeer(peer) {
    const router = RouterContainer.get();
    const currentPeer = DialogStore.getCurrentPeer();

    // Unbind from previous peer
    if (currentPeer !== null) {
      this.onConversationClosed(currentPeer);
      ActorClient.unbindChat(currentPeer, MessageActionCreators.setMessages);
      ActorClient.unbindTyping(currentPeer, this.setTyping);

      switch (currentPeer.type) {
        case PeerTypes.USER:
          ActorClient.unbindUser(currentPeer.id, this.setDialogInfo);
          break;
        case PeerTypes.GROUP:
          ActorClient.unbindGroup(currentPeer.id, this.setDialogInfo);
          break;
        default:
      }
    }

    dispatch(ActionTypes.SELECT_DIALOG_PEER, { peer });

    this.onConversationOpen(peer);
    ActorClient.bindChat(peer, MessageActionCreators.setMessages);
    ActorClient.bindTyping(peer, this.setTyping);
    switch(peer.type) {
      case PeerTypes.USER:
        ActorClient.bindUser(peer.id, this.setDialogInfo);
        break;
      case PeerTypes.GROUP:
        ActorClient.bindGroup(peer.id, this.setDialogInfo);
        GroupProfileActionCreators.getIntegrationToken(peer.id);
        break;
      default:
    }

    router.transitionTo('main', {id: PeerUtils.peerToString(peer)});
  },

  selectDialogPeerUser(uid) {
    if (uid === ActorClient.getUid()) {
      console.warn('You can\'t chat with yourself');
    } else {
      this.selectDialogPeer(ActorClient.getUserPeer(uid));
    }
  },

  setDialogInfo(info) {
    dispatch(ActionTypes.DIALOG_INFO_CHANGED, { info });
  },

  setTyping(typing) {
    dispatch(ActionTypes.DIALOG_TYPING_CHANGED, { typing: typing.typing });
  },

  onConversationOpen(peer) {
    ActorClient.onConversationOpen(peer);
  },

  onConversationClosed(peer) {
    ActorClient.onConversationClosed(peer);
  },

  onDialogsEnd() {
    ActorClient.onDialogsEnd();
  },

  onChatEnd(peer) {
    ActorClient.onChatEnd(peer);
  },

  leaveGroup(gid) {
    dispatchAsync(ActorClient.leaveGroup(gid), {
      request: ActionTypes.GROUP_LEAVE,
      success: ActionTypes.GROUP_LEAVE_SUCCESS,
      failure: ActionTypes.GROUP_LEAVE_ERROR
    }, { gid });
  },

  changeNotificationsEnabled(peer, isEnabled) {
    ActorClient.changeNotificationsEnabled(peer, isEnabled);
    dispatch(ActionTypes.NOTIFICATION_CHANGE, { peer, isEnabled });
  },

  deleteChat(peer) {
    const gid = peer.id;
    const leaveGroup = () => dispatchAsync(ActorClient.leaveGroup(gid), {
      request: ActionTypes.GROUP_LEAVE,
      success: ActionTypes.GROUP_LEAVE_SUCCESS,
      failure: ActionTypes.GROUP_LEAVE_ERROR
    }, { gid });
    const deleteChat = () => dispatchAsync(ActorClient.deleteChat(peer), {
      request: ActionTypes.GROUP_DELETE,
      success: ActionTypes.GROUP_DELETE_SUCCESS,
      failure: ActionTypes.GROUP_DELETE_ERROR
    }, { peer });

    switch (peer.type) {
      case PeerTypes.USER:
        deleteChat();
        break;
      case PeerTypes.GROUP:
        leaveGroup()
          .then(deleteChat);
        break;
      default:
    }
  },

  clearChat(peer) {
    dispatchAsync(ActorClient.clearChat(peer), {
      request: ActionTypes.GROUP_CLEAR,
      success: ActionTypes.GROUP_CLEAR_SUCCESS,
      failure: ActionTypes.GROUP_CLEAR_ERROR
    }, { peer });
  },

  hideChat(peer) {
    dispatchAsync(ActorClient.hideChat(peer), {
      request: ActionTypes.GROUP_HIDE,
      success: ActionTypes.GROUP_HIDE_SUCCESS,
      failure: ActionTypes.GROUP_HIDE_ERROR
    }, { peer });
  }
};

export default DialogActionCreators;
