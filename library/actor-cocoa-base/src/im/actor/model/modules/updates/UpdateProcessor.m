//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/modules/updates/UpdateProcessor.java
//

#line 1 "/Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/modules/updates/UpdateProcessor.java"

#include "IOSObjectArray.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/Avatar.h"
#include "im/actor/model/api/Group.h"
#include "im/actor/model/api/Message.h"
#include "im/actor/model/api/Peer.h"
#include "im/actor/model/api/PeerType.h"
#include "im/actor/model/api/TypingType.h"
#include "im/actor/model/api/User.h"
#include "im/actor/model/api/rpc/ResponseAuth.h"
#include "im/actor/model/api/rpc/ResponseGetContacts.h"
#include "im/actor/model/api/rpc/ResponseLoadDialogs.h"
#include "im/actor/model/api/rpc/ResponseLoadHistory.h"
#include "im/actor/model/api/updates/UpdateChatClear.h"
#include "im/actor/model/api/updates/UpdateChatDelete.h"
#include "im/actor/model/api/updates/UpdateContactRegistered.h"
#include "im/actor/model/api/updates/UpdateContactsAdded.h"
#include "im/actor/model/api/updates/UpdateContactsRemoved.h"
#include "im/actor/model/api/updates/UpdateGroupAvatarChanged.h"
#include "im/actor/model/api/updates/UpdateGroupInvite.h"
#include "im/actor/model/api/updates/UpdateGroupMembersUpdate.h"
#include "im/actor/model/api/updates/UpdateGroupOnline.h"
#include "im/actor/model/api/updates/UpdateGroupTitleChanged.h"
#include "im/actor/model/api/updates/UpdateGroupUserAdded.h"
#include "im/actor/model/api/updates/UpdateGroupUserKick.h"
#include "im/actor/model/api/updates/UpdateGroupUserLeave.h"
#include "im/actor/model/api/updates/UpdateMessage.h"
#include "im/actor/model/api/updates/UpdateMessageDelete.h"
#include "im/actor/model/api/updates/UpdateMessageRead.h"
#include "im/actor/model/api/updates/UpdateMessageReadByMe.h"
#include "im/actor/model/api/updates/UpdateMessageReceived.h"
#include "im/actor/model/api/updates/UpdateMessageSent.h"
#include "im/actor/model/api/updates/UpdateTyping.h"
#include "im/actor/model/api/updates/UpdateUserAvatarChanged.h"
#include "im/actor/model/api/updates/UpdateUserLastSeen.h"
#include "im/actor/model/api/updates/UpdateUserLocalNameChanged.h"
#include "im/actor/model/api/updates/UpdateUserNameChanged.h"
#include "im/actor/model/api/updates/UpdateUserOffline.h"
#include "im/actor/model/api/updates/UpdateUserOnline.h"
#include "im/actor/model/concurrency/CommandCallback.h"
#include "im/actor/model/droidkit/actors/ActorRef.h"
#include "im/actor/model/entity/Avatar.h"
#include "im/actor/model/entity/Peer.h"
#include "im/actor/model/log/Log.h"
#include "im/actor/model/modules/BaseModule.h"
#include "im/actor/model/modules/Contacts.h"
#include "im/actor/model/modules/Modules.h"
#include "im/actor/model/modules/Users.h"
#include "im/actor/model/modules/contacts/ContactsSyncActor.h"
#include "im/actor/model/modules/messages/entity/EntityConverter.h"
#include "im/actor/model/modules/updates/ContactsProcessor.h"
#include "im/actor/model/modules/updates/GroupsProcessor.h"
#include "im/actor/model/modules/updates/MessagesProcessor.h"
#include "im/actor/model/modules/updates/PresenceProcessor.h"
#include "im/actor/model/modules/updates/TypingProcessor.h"
#include "im/actor/model/modules/updates/UpdateProcessor.h"
#include "im/actor/model/modules/updates/UsersProcessor.h"
#include "im/actor/model/modules/updates/internal/ContactsLoaded.h"
#include "im/actor/model/modules/updates/internal/DialogHistoryLoaded.h"
#include "im/actor/model/modules/updates/internal/GroupCreated.h"
#include "im/actor/model/modules/updates/internal/InternalUpdate.h"
#include "im/actor/model/modules/updates/internal/LoggedIn.h"
#include "im/actor/model/modules/updates/internal/MessagesHistoryLoaded.h"
#include "im/actor/model/modules/updates/internal/UsersFounded.h"
#include "im/actor/model/mvvm/MVVMCollection.h"
#include "im/actor/model/network/parser/Update.h"
#include "im/actor/model/viewmodel/UserVM.h"
#include "java/lang/Integer.h"
#include "java/lang/Runnable.h"
#include "java/util/ArrayList.h"
#include "java/util/HashSet.h"
#include "java/util/List.h"

@interface ImActorModelModulesUpdatesUpdateProcessor () {
 @public
  ImActorModelModulesUpdatesUsersProcessor *usersProcessor_;
  ImActorModelModulesUpdatesMessagesProcessor *messagesProcessor_;
  ImActorModelModulesUpdatesGroupsProcessor *groupsProcessor_;
  ImActorModelModulesUpdatesPresenceProcessor *presenceProcessor_;
  ImActorModelModulesUpdatesTypingProcessor *typingProcessor_;
  ImActorModelModulesUpdatesContactsProcessor *contactsProcessor_;
}
@end

J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor, usersProcessor_, ImActorModelModulesUpdatesUsersProcessor *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor, messagesProcessor_, ImActorModelModulesUpdatesMessagesProcessor *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor, groupsProcessor_, ImActorModelModulesUpdatesGroupsProcessor *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor, presenceProcessor_, ImActorModelModulesUpdatesPresenceProcessor *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor, typingProcessor_, ImActorModelModulesUpdatesTypingProcessor *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor, contactsProcessor_, ImActorModelModulesUpdatesContactsProcessor *)

@interface ImActorModelModulesUpdatesUpdateProcessor_$1 () {
 @public
  ImActorModelModulesUpdatesInternalUsersFounded *val$founded_;
  JavaUtilArrayList *val$users_;
}
@end

J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor_$1, val$founded_, ImActorModelModulesUpdatesInternalUsersFounded *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor_$1, val$users_, JavaUtilArrayList *)

@interface ImActorModelModulesUpdatesUpdateProcessor_$2 () {
 @public
  ImActorModelModulesUpdatesInternalGroupCreated *val$created_;
}
@end

J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesUpdateProcessor_$2, val$created_, ImActorModelModulesUpdatesInternalGroupCreated *)


#line 55
@implementation ImActorModelModulesUpdatesUpdateProcessor

NSString * ImActorModelModulesUpdatesUpdateProcessor_TAG_ = @"Updates";


#line 66
- (instancetype)initWithImActorModelModulesModules:(ImActorModelModulesModules *)modules {
  if (self =
#line 67
  [super initWithImActorModelModulesModules:modules]) {
    
#line 68
    self->usersProcessor_ = [[ImActorModelModulesUpdatesUsersProcessor alloc] initWithImActorModelModulesModules:modules];
    
#line 69
    self->messagesProcessor_ = [[ImActorModelModulesUpdatesMessagesProcessor alloc] initWithImActorModelModulesModules:modules];
    
#line 70
    self->groupsProcessor_ = [[ImActorModelModulesUpdatesGroupsProcessor alloc] initWithImActorModelModulesModules:modules];
    
#line 71
    self->presenceProcessor_ = [[ImActorModelModulesUpdatesPresenceProcessor alloc] initWithImActorModelModulesModules:modules];
    
#line 72
    self->typingProcessor_ = [[ImActorModelModulesUpdatesTypingProcessor alloc] initWithImActorModelModulesModules:modules];
    
#line 73
    self->contactsProcessor_ = [[ImActorModelModulesUpdatesContactsProcessor alloc] initWithImActorModelModulesModules:modules];
  }
  return self;
}


#line 76
- (void)applyRelatedWithJavaUtilList:(id<JavaUtilList>)users
                    withJavaUtilList:(id<JavaUtilList>)groups
                         withBoolean:(jboolean)force {
  
#line 79
  [((ImActorModelModulesUpdatesUsersProcessor *) nil_chk(usersProcessor_)) applyUsersWithJavaUtilCollection:users withBoolean:force];
  [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) applyGroupsWithJavaUtilCollection:groups withBoolean:force];
}


#line 83
- (void)processInternalUpdateWithImActorModelModulesUpdatesInternalInternalUpdate:(ImActorModelModulesUpdatesInternalInternalUpdate *)update {
  
#line 84
  if ([update isKindOfClass:[ImActorModelModulesUpdatesInternalDialogHistoryLoaded class]]) {
    ImActorModelApiRpcResponseLoadDialogs *dialogs = [((ImActorModelModulesUpdatesInternalDialogHistoryLoaded *) nil_chk(((ImActorModelModulesUpdatesInternalDialogHistoryLoaded *) check_class_cast(update, [ImActorModelModulesUpdatesInternalDialogHistoryLoaded class])))) getDialogs];
    [self applyRelatedWithJavaUtilList:[((ImActorModelApiRpcResponseLoadDialogs *) nil_chk(dialogs)) getUsers] withJavaUtilList:[dialogs getGroups] withBoolean:NO];
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onDialogsLoadedWithImActorModelApiRpcResponseLoadDialogs:dialogs];
  }
  else
#line 88
  if ([update isKindOfClass:[ImActorModelModulesUpdatesInternalMessagesHistoryLoaded class]]) {
    ImActorModelModulesUpdatesInternalMessagesHistoryLoaded *historyLoaded = (ImActorModelModulesUpdatesInternalMessagesHistoryLoaded *) check_class_cast(update, [ImActorModelModulesUpdatesInternalMessagesHistoryLoaded class]);
    [self applyRelatedWithJavaUtilList:[((ImActorModelApiRpcResponseLoadHistory *) nil_chk([((ImActorModelModulesUpdatesInternalMessagesHistoryLoaded *) nil_chk(historyLoaded)) getLoadHistory])) getUsers] withJavaUtilList:[[JavaUtilArrayList alloc] init] withBoolean:NO];
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessagesLoadedWithAMPeer:[historyLoaded getPeer] withImActorModelApiRpcResponseLoadHistory:[historyLoaded getLoadHistory]];
  }
  else
#line 92
  if ([update isKindOfClass:[ImActorModelModulesUpdatesInternalLoggedIn class]]) {
    JavaUtilArrayList *users = [[JavaUtilArrayList alloc] init];
    [users addWithId:[((ImActorModelApiRpcResponseAuth *) nil_chk([((ImActorModelModulesUpdatesInternalLoggedIn *) nil_chk(((ImActorModelModulesUpdatesInternalLoggedIn *) check_class_cast(update, [ImActorModelModulesUpdatesInternalLoggedIn class])))) getAuth])) getUser]];
    [self applyRelatedWithJavaUtilList:users withJavaUtilList:[[JavaUtilArrayList alloc] init] withBoolean:YES];
    [self runOnUiThreadWithJavaLangRunnable:[((ImActorModelModulesUpdatesInternalLoggedIn *) nil_chk(((ImActorModelModulesUpdatesInternalLoggedIn *) check_class_cast(update, [ImActorModelModulesUpdatesInternalLoggedIn class])))) getRunnable]];
  }
  else
#line 97
  if ([update isKindOfClass:[ImActorModelModulesUpdatesInternalContactsLoaded class]]) {
    ImActorModelModulesUpdatesInternalContactsLoaded *contactsLoaded = (ImActorModelModulesUpdatesInternalContactsLoaded *) check_class_cast(update, [ImActorModelModulesUpdatesInternalContactsLoaded class]);
    [self applyRelatedWithJavaUtilList:[((ImActorModelApiRpcResponseGetContacts *) nil_chk([((ImActorModelModulesUpdatesInternalContactsLoaded *) nil_chk(contactsLoaded)) getContacts])) getUsers] withJavaUtilList:[[JavaUtilArrayList alloc] init] withBoolean:NO];
    [((DKActorRef *) nil_chk([((ImActorModelModulesContacts *) nil_chk([((ImActorModelModulesModules *) nil_chk([self modules])) getContactsModule])) getContactSyncActor])) sendWithId:
#line 101
    [[ImActorModelModulesContactsContactsSyncActor_ContactsLoaded alloc] initWithImActorModelApiRpcResponseGetContacts:[contactsLoaded getContacts]]];
  }
  else
#line 102
  if ([update isKindOfClass:[ImActorModelModulesUpdatesInternalUsersFounded class]]) {
    ImActorModelModulesUpdatesInternalUsersFounded *founded = (ImActorModelModulesUpdatesInternalUsersFounded *) check_class_cast(update, [ImActorModelModulesUpdatesInternalUsersFounded class]);
    [self applyRelatedWithJavaUtilList:[((ImActorModelModulesUpdatesInternalUsersFounded *) nil_chk(((ImActorModelModulesUpdatesInternalUsersFounded *) check_class_cast(update, [ImActorModelModulesUpdatesInternalUsersFounded class])))) getUsers] withJavaUtilList:[[JavaUtilArrayList alloc] init] withBoolean:NO];
    JavaUtilArrayList *users = [[JavaUtilArrayList alloc] init];
    for (ImActorModelApiUser * __strong u in nil_chk([((ImActorModelModulesUpdatesInternalUsersFounded *) nil_chk(founded)) getUsers])) {
      [users addWithId:[((AMMVVMCollection *) nil_chk([((ImActorModelModulesUsers *) nil_chk([((ImActorModelModulesModules *) nil_chk([self modules])) getUsersModule])) getUsersCollection])) getWithLong:[((ImActorModelApiUser *) nil_chk(u)) getId]]];
    }
    [self runOnUiThreadWithJavaLangRunnable:[[ImActorModelModulesUpdatesUpdateProcessor_$1 alloc] initWithImActorModelModulesUpdatesInternalUsersFounded:founded withJavaUtilArrayList:users]];
  }
  else
#line 115
  if ([update isKindOfClass:[ImActorModelModulesUpdatesInternalGroupCreated class]]) {
    ImActorModelModulesUpdatesInternalGroupCreated *created = (ImActorModelModulesUpdatesInternalGroupCreated *) check_class_cast(update, [ImActorModelModulesUpdatesInternalGroupCreated class]);
    JavaUtilArrayList *groups = [[JavaUtilArrayList alloc] init];
    [groups addWithId:[((ImActorModelModulesUpdatesInternalGroupCreated *) nil_chk(created)) getGroup]];
    [self applyRelatedWithJavaUtilList:[[JavaUtilArrayList alloc] init] withJavaUtilList:groups withBoolean:NO];
    [self runOnUiThreadWithJavaLangRunnable:[[ImActorModelModulesUpdatesUpdateProcessor_$2 alloc] initWithImActorModelModulesUpdatesInternalGroupCreated:created]];
  }
}


#line 129
- (void)processUpdateWithImActorModelNetworkParserUpdate:(ImActorModelNetworkParserUpdate *)update {
  
#line 130
  AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesUpdateProcessor_TAG_, JreStrcat("@", update));
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserNameChanged class]]) {
    ImActorModelApiUpdatesUpdateUserNameChanged *userNameChanged = (ImActorModelApiUpdatesUpdateUserNameChanged *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserNameChanged class]);
    [((ImActorModelModulesUpdatesUsersProcessor *) nil_chk(usersProcessor_)) onUserNameChangedWithInt:[((ImActorModelApiUpdatesUpdateUserNameChanged *) nil_chk(userNameChanged)) getUid] withNSString:[userNameChanged getName]];
  }
  else
#line 134
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserLocalNameChanged class]]) {
    ImActorModelApiUpdatesUpdateUserLocalNameChanged *localNameChanged = (ImActorModelApiUpdatesUpdateUserLocalNameChanged *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserLocalNameChanged class]);
    [((ImActorModelModulesUpdatesUsersProcessor *) nil_chk(usersProcessor_)) onUserLocalNameChangedWithInt:[((ImActorModelApiUpdatesUpdateUserLocalNameChanged *) nil_chk(localNameChanged)) getUid] withNSString:[localNameChanged getLocalName]];
  }
  else
#line 137
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserAvatarChanged class]]) {
    ImActorModelApiUpdatesUpdateUserAvatarChanged *avatarChanged = (ImActorModelApiUpdatesUpdateUserAvatarChanged *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserAvatarChanged class]);
    [((ImActorModelModulesUpdatesUsersProcessor *) nil_chk(usersProcessor_)) onUserAvatarChangedWithInt:[((ImActorModelApiUpdatesUpdateUserAvatarChanged *) nil_chk(avatarChanged)) getUid] withImActorModelApiAvatar:[avatarChanged getAvatar]];
  }
  else
#line 140
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessage class]]) {
    ImActorModelApiUpdatesUpdateMessage *message = (ImActorModelApiUpdatesUpdateMessage *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessage class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessageWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateMessage *) nil_chk(message)) getPeer] withInt:[message getSenderUid] withLong:[message getDate] withLong:[message getRid] withImActorModelApiMessage:
#line 143
    [message getMessage]];
    [((ImActorModelModulesUpdatesTypingProcessor *) nil_chk(typingProcessor_)) onMessageWithImActorModelApiPeer:[message getPeer] withInt:[message getSenderUid]];
  }
  else
#line 145
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessageRead class]]) {
    ImActorModelApiUpdatesUpdateMessageRead *messageRead = (ImActorModelApiUpdatesUpdateMessageRead *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessageRead class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessageReadWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateMessageRead *) nil_chk(messageRead)) getPeer] withLong:[messageRead getStartDate] withLong:[messageRead getReadDate]];
  }
  else
#line 148
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessageReadByMe class]]) {
    ImActorModelApiUpdatesUpdateMessageReadByMe *messageReadByMe = (ImActorModelApiUpdatesUpdateMessageReadByMe *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessageReadByMe class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessageReadByMeWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateMessageReadByMe *) nil_chk(messageReadByMe)) getPeer] withLong:[messageReadByMe getStartDate]];
  }
  else
#line 151
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessageReceived class]]) {
    ImActorModelApiUpdatesUpdateMessageReceived *received = (ImActorModelApiUpdatesUpdateMessageReceived *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessageReceived class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessageReceivedWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateMessageReceived *) nil_chk(received)) getPeer] withLong:[received getStartDate] withLong:[received getReceivedDate]];
  }
  else
#line 154
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessageDelete class]]) {
    ImActorModelApiUpdatesUpdateMessageDelete *messageDelete = (ImActorModelApiUpdatesUpdateMessageDelete *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessageDelete class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessageDeleteWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateMessageDelete *) nil_chk(messageDelete)) getPeer] withJavaUtilList:[messageDelete getRids]];
  }
  else
#line 157
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessageSent class]]) {
    ImActorModelApiUpdatesUpdateMessageSent *messageSent = (ImActorModelApiUpdatesUpdateMessageSent *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessageSent class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onMessageSentWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateMessageSent *) nil_chk(messageSent)) getPeer] withLong:[messageSent getRid] withLong:[messageSent getDate]];
  }
  else
#line 160
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateChatClear class]]) {
    ImActorModelApiUpdatesUpdateChatClear *chatClear = (ImActorModelApiUpdatesUpdateChatClear *) check_class_cast(update, [ImActorModelApiUpdatesUpdateChatClear class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onChatClearWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateChatClear *) nil_chk(chatClear)) getPeer]];
  }
  else
#line 163
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateChatDelete class]]) {
    ImActorModelApiUpdatesUpdateChatDelete *chatDelete = (ImActorModelApiUpdatesUpdateChatDelete *) check_class_cast(update, [ImActorModelApiUpdatesUpdateChatDelete class]);
    [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onChatDeleteWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateChatDelete *) nil_chk(chatDelete)) getPeer]];
  }
  else
#line 166
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateContactRegistered class]]) {
    ImActorModelApiUpdatesUpdateContactRegistered *registered = (ImActorModelApiUpdatesUpdateContactRegistered *) check_class_cast(update, [ImActorModelApiUpdatesUpdateContactRegistered class]);
    if (![((ImActorModelApiUpdatesUpdateContactRegistered *) nil_chk(registered)) isSilent]) {
      [((ImActorModelModulesUpdatesMessagesProcessor *) nil_chk(messagesProcessor_)) onUserRegisteredWithInt:[registered getUid] withLong:[registered getDate]];
    }
  }
  else
#line 171
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserOnline class]]) {
    ImActorModelApiUpdatesUpdateUserOnline *userOnline = (ImActorModelApiUpdatesUpdateUserOnline *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserOnline class]);
    [((ImActorModelModulesUpdatesPresenceProcessor *) nil_chk(presenceProcessor_)) onUserOnlineWithInt:[((ImActorModelApiUpdatesUpdateUserOnline *) nil_chk(userOnline)) getUid]];
  }
  else
#line 174
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserOffline class]]) {
    ImActorModelApiUpdatesUpdateUserOffline *offline = (ImActorModelApiUpdatesUpdateUserOffline *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserOffline class]);
    [((ImActorModelModulesUpdatesPresenceProcessor *) nil_chk(presenceProcessor_)) onUserOfflineWithInt:[((ImActorModelApiUpdatesUpdateUserOffline *) nil_chk(offline)) getUid]];
  }
  else
#line 177
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserLastSeen class]]) {
    ImActorModelApiUpdatesUpdateUserLastSeen *lastSeen = (ImActorModelApiUpdatesUpdateUserLastSeen *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserLastSeen class]);
    [((ImActorModelModulesUpdatesPresenceProcessor *) nil_chk(presenceProcessor_)) onUserLastSeenWithInt:[((ImActorModelApiUpdatesUpdateUserLastSeen *) nil_chk(lastSeen)) getUid] withLong:[lastSeen getDate]];
  }
  else
#line 180
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupOnline class]]) {
    ImActorModelApiUpdatesUpdateGroupOnline *groupOnline = (ImActorModelApiUpdatesUpdateGroupOnline *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupOnline class]);
    [((ImActorModelModulesUpdatesPresenceProcessor *) nil_chk(presenceProcessor_)) onGroupOnlineWithInt:[((ImActorModelApiUpdatesUpdateGroupOnline *) nil_chk(groupOnline)) getGroupId] withInt:[groupOnline getCount]];
  }
  else
#line 183
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateTyping class]]) {
    ImActorModelApiUpdatesUpdateTyping *typing = (ImActorModelApiUpdatesUpdateTyping *) check_class_cast(update, [ImActorModelApiUpdatesUpdateTyping class]);
    [((ImActorModelModulesUpdatesTypingProcessor *) nil_chk(typingProcessor_)) onTypingWithImActorModelApiPeer:[((ImActorModelApiUpdatesUpdateTyping *) nil_chk(typing)) getPeer] withInt:[typing getUid] withImActorModelApiTypingTypeEnum:[typing getTypingType]];
  }
  else
#line 186
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupTitleChanged class]]) {
    ImActorModelApiUpdatesUpdateGroupTitleChanged *titleChanged = (ImActorModelApiUpdatesUpdateGroupTitleChanged *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupTitleChanged class]);
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onTitleChangedWithInt:[((ImActorModelApiUpdatesUpdateGroupTitleChanged *) nil_chk(titleChanged)) getGroupId] withLong:[titleChanged getRid] withInt:
#line 189
    [titleChanged getUid] withNSString:[titleChanged getTitle] withLong:[titleChanged getDate] withBoolean:
#line 190
    NO];
  }
  else
#line 191
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupAvatarChanged class]]) {
    ImActorModelApiUpdatesUpdateGroupAvatarChanged *avatarChanged = (ImActorModelApiUpdatesUpdateGroupAvatarChanged *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupAvatarChanged class]);
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onAvatarChangedWithInt:[((ImActorModelApiUpdatesUpdateGroupAvatarChanged *) nil_chk(avatarChanged)) getGroupId] withLong:[avatarChanged getRid] withInt:
#line 194
    [avatarChanged getUid] withAMAvatar:ImActorModelModulesMessagesEntityEntityConverter_convertWithImActorModelApiAvatar_([avatarChanged getAvatar]) withLong:
#line 195
    [avatarChanged getDate] withBoolean:NO];
  }
  else
#line 196
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupInvite class]]) {
    ImActorModelApiUpdatesUpdateGroupInvite *groupInvite = (ImActorModelApiUpdatesUpdateGroupInvite *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupInvite class]);
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onGroupInviteWithInt:[((ImActorModelApiUpdatesUpdateGroupInvite *) nil_chk(groupInvite)) getGroupId] withLong:
#line 199
    [groupInvite getRid] withInt:[groupInvite getInviteUid] withLong:[groupInvite getDate] withBoolean:
#line 200
    NO];
  }
  else
#line 201
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupUserLeave class]]) {
    ImActorModelApiUpdatesUpdateGroupUserLeave *leave = (ImActorModelApiUpdatesUpdateGroupUserLeave *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupUserLeave class]);
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onUserLeaveWithInt:[((ImActorModelApiUpdatesUpdateGroupUserLeave *) nil_chk(leave)) getGroupId] withLong:[leave getRid] withInt:[leave getUid] withLong:
#line 204
    [leave getDate] withBoolean:NO];
  }
  else
#line 205
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupUserKick class]]) {
    ImActorModelApiUpdatesUpdateGroupUserKick *userKick = (ImActorModelApiUpdatesUpdateGroupUserKick *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupUserKick class]);
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onUserKickedWithInt:[((ImActorModelApiUpdatesUpdateGroupUserKick *) nil_chk(userKick)) getGroupId] withLong:
#line 208
    [userKick getRid] withInt:[userKick getUid] withInt:[userKick getKickerUid] withLong:[userKick getDate] withBoolean:
#line 209
    NO];
  }
  else
#line 210
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupUserAdded class]]) {
    ImActorModelApiUpdatesUpdateGroupUserAdded *userAdded = (ImActorModelApiUpdatesUpdateGroupUserAdded *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupUserAdded class]);
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onUserAddedWithInt:[((ImActorModelApiUpdatesUpdateGroupUserAdded *) nil_chk(userAdded)) getGroupId] withLong:
#line 213
    [userAdded getRid] withInt:[userAdded getUid] withInt:[userAdded getInviterUid] withLong:[userAdded getDate] withBoolean:
#line 214
    NO];
  }
  else
#line 215
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateContactsAdded class]]) {
    ImActorModelApiUpdatesUpdateContactsAdded *contactsAdded = (ImActorModelApiUpdatesUpdateContactsAdded *) check_class_cast(update, [ImActorModelApiUpdatesUpdateContactsAdded class]);
    IOSIntArray *res = [IOSIntArray newArrayWithLength:[((id<JavaUtilList>) nil_chk([((ImActorModelApiUpdatesUpdateContactsAdded *) nil_chk(contactsAdded)) getUids])) size]];
    for (jint i = 0; i < res->size_; i++) {
      *IOSIntArray_GetRef(res, i) = [((JavaLangInteger *) nil_chk([((id<JavaUtilList>) nil_chk([contactsAdded getUids])) getWithInt:i])) intValue];
    }
    [((ImActorModelModulesUpdatesContactsProcessor *) nil_chk(contactsProcessor_)) onContactsAddedWithIntArray:res];
  }
  else
#line 222
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateContactsRemoved class]]) {
    ImActorModelApiUpdatesUpdateContactsRemoved *contactsRemoved = (ImActorModelApiUpdatesUpdateContactsRemoved *) check_class_cast(update, [ImActorModelApiUpdatesUpdateContactsRemoved class]);
    IOSIntArray *res = [IOSIntArray newArrayWithLength:[((id<JavaUtilList>) nil_chk([((ImActorModelApiUpdatesUpdateContactsRemoved *) nil_chk(contactsRemoved)) getUids])) size]];
    for (jint i = 0; i < res->size_; i++) {
      *IOSIntArray_GetRef(res, i) = [((JavaLangInteger *) nil_chk([((id<JavaUtilList>) nil_chk([contactsRemoved getUids])) getWithInt:i])) intValue];
    }
    [((ImActorModelModulesUpdatesContactsProcessor *) nil_chk(contactsProcessor_)) onContactsRemovedWithIntArray:res];
  }
  else
#line 229
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupMembersUpdate class]]) {
    [((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) onMembersUpdatedWithInt:[((ImActorModelApiUpdatesUpdateGroupMembersUpdate *) nil_chk(((ImActorModelApiUpdatesUpdateGroupMembersUpdate *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupMembersUpdate class])))) getGroupId] withJavaUtilList:
#line 231
    [((ImActorModelApiUpdatesUpdateGroupMembersUpdate *) nil_chk(((ImActorModelApiUpdatesUpdateGroupMembersUpdate *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupMembersUpdate class])))) getMembers]];
  }
}


#line 236
- (jboolean)isCausesInvalidationWithImActorModelNetworkParserUpdate:(ImActorModelNetworkParserUpdate *)update {
  
#line 237
  JavaUtilHashSet *users = [[JavaUtilHashSet alloc] init];
  JavaUtilHashSet *groups = [[JavaUtilHashSet alloc] init];
  
#line 240
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateMessage class]]) {
    ImActorModelApiUpdatesUpdateMessage *updateMessage = (ImActorModelApiUpdatesUpdateMessage *) check_class_cast(update, [ImActorModelApiUpdatesUpdateMessage class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateMessage *) nil_chk(updateMessage)) getSenderUid])];
    if ([((ImActorModelApiPeer *) nil_chk([updateMessage getPeer])) getType] == ImActorModelApiPeerTypeEnum_get_GROUP()) {
      [groups addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiPeer *) nil_chk([updateMessage getPeer])) getId])];
    }
    if ([((ImActorModelApiPeer *) nil_chk([updateMessage getPeer])) getType] == ImActorModelApiPeerTypeEnum_get_PRIVATE()) {
      [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiPeer *) nil_chk([updateMessage getPeer])) getId])];
    }
  }
  else
#line 249
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateContactRegistered class]]) {
    ImActorModelApiUpdatesUpdateContactRegistered *contactRegistered = (ImActorModelApiUpdatesUpdateContactRegistered *) check_class_cast(update, [ImActorModelApiUpdatesUpdateContactRegistered class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateContactRegistered *) nil_chk(contactRegistered)) getUid])];
  }
  else
#line 252
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupInvite class]]) {
    ImActorModelApiUpdatesUpdateGroupInvite *groupInvite = (ImActorModelApiUpdatesUpdateGroupInvite *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupInvite class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateGroupInvite *) nil_chk(groupInvite)) getInviteUid])];
    [groups addWithId:JavaLangInteger_valueOfWithInt_([groupInvite getGroupId])];
  }
  else
#line 256
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupUserAdded class]]) {
    ImActorModelApiUpdatesUpdateGroupUserAdded *added = (ImActorModelApiUpdatesUpdateGroupUserAdded *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupUserAdded class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateGroupUserAdded *) nil_chk(added)) getInviterUid])];
    [users addWithId:JavaLangInteger_valueOfWithInt_([added getUid])];
    [groups addWithId:JavaLangInteger_valueOfWithInt_([added getGroupId])];
  }
  else
#line 261
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupUserKick class]]) {
    ImActorModelApiUpdatesUpdateGroupUserKick *kick = (ImActorModelApiUpdatesUpdateGroupUserKick *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupUserKick class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateGroupUserKick *) nil_chk(kick)) getKickerUid])];
    [users addWithId:JavaLangInteger_valueOfWithInt_([kick getUid])];
    [groups addWithId:JavaLangInteger_valueOfWithInt_([kick getGroupId])];
  }
  else
#line 266
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateGroupUserLeave class]]) {
    ImActorModelApiUpdatesUpdateGroupUserLeave *leave = (ImActorModelApiUpdatesUpdateGroupUserLeave *) check_class_cast(update, [ImActorModelApiUpdatesUpdateGroupUserLeave class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateGroupUserLeave *) nil_chk(leave)) getUid])];
    [groups addWithId:JavaLangInteger_valueOfWithInt_([leave getGroupId])];
  }
  else
#line 270
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateContactsAdded class]]) {
    [users addAllWithJavaUtilCollection:[((ImActorModelApiUpdatesUpdateContactsAdded *) nil_chk(((ImActorModelApiUpdatesUpdateContactsAdded *) check_class_cast(update, [ImActorModelApiUpdatesUpdateContactsAdded class])))) getUids]];
  }
  else
#line 272
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateContactsRemoved class]]) {
    [users addAllWithJavaUtilCollection:[((ImActorModelApiUpdatesUpdateContactsRemoved *) nil_chk(((ImActorModelApiUpdatesUpdateContactsRemoved *) check_class_cast(update, [ImActorModelApiUpdatesUpdateContactsRemoved class])))) getUids]];
  }
  else
#line 274
  if ([update isKindOfClass:[ImActorModelApiUpdatesUpdateUserLocalNameChanged class]]) {
    ImActorModelApiUpdatesUpdateUserLocalNameChanged *localNameChanged = (ImActorModelApiUpdatesUpdateUserLocalNameChanged *) check_class_cast(update, [ImActorModelApiUpdatesUpdateUserLocalNameChanged class]);
    [users addWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiUpdatesUpdateUserLocalNameChanged *) nil_chk(localNameChanged)) getUid])];
  }
  
#line 279
  if (![((ImActorModelModulesUpdatesUsersProcessor *) nil_chk(usersProcessor_)) hasUsersWithJavaUtilCollection:users]) {
    return YES;
  }
  
#line 283
  if (![((ImActorModelModulesUpdatesGroupsProcessor *) nil_chk(groupsProcessor_)) hasGroupsWithJavaUtilCollection:groups]) {
    return YES;
  }
  
#line 287
  return NO;
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesUpdateProcessor *)other {
  [super copyAllFieldsTo:other];
  other->usersProcessor_ = usersProcessor_;
  other->messagesProcessor_ = messagesProcessor_;
  other->groupsProcessor_ = groupsProcessor_;
  other->presenceProcessor_ = presenceProcessor_;
  other->typingProcessor_ = typingProcessor_;
  other->contactsProcessor_ = contactsProcessor_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesUpdateProcessor)

@implementation ImActorModelModulesUpdatesUpdateProcessor_$1


#line 111
- (void)run {
  
#line 112
  [((id<AMCommandCallback>) nil_chk([((ImActorModelModulesUpdatesInternalUsersFounded *) nil_chk(val$founded_)) getCommandCallback])) onResultWithId:[val$users_ toArrayWithNSObjectArray:[IOSObjectArray newArrayWithLength:[((JavaUtilArrayList *) nil_chk(val$users_)) size] type:AMUserVM_class_()]]];
}

- (instancetype)initWithImActorModelModulesUpdatesInternalUsersFounded:(ImActorModelModulesUpdatesInternalUsersFounded *)capture$0
                                                 withJavaUtilArrayList:(JavaUtilArrayList *)capture$1 {
  val$founded_ = capture$0;
  val$users_ = capture$1;
  return [super init];
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesUpdateProcessor_$1 *)other {
  [super copyAllFieldsTo:other];
  other->val$founded_ = val$founded_;
  other->val$users_ = val$users_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesUpdateProcessor_$1)

@implementation ImActorModelModulesUpdatesUpdateProcessor_$2


#line 122
- (void)run {
  
#line 123
  [((id<AMCommandCallback>) nil_chk([((ImActorModelModulesUpdatesInternalGroupCreated *) nil_chk(val$created_)) getCallback])) onResultWithId:JavaLangInteger_valueOfWithInt_([((ImActorModelApiGroup *) nil_chk([val$created_ getGroup])) getId])];
}

- (instancetype)initWithImActorModelModulesUpdatesInternalGroupCreated:(ImActorModelModulesUpdatesInternalGroupCreated *)capture$0 {
  val$created_ = capture$0;
  return [super init];
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesUpdateProcessor_$2 *)other {
  [super copyAllFieldsTo:other];
  other->val$created_ = val$created_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesUpdateProcessor_$2)
