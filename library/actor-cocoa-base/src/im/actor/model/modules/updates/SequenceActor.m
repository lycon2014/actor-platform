//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/modules/updates/SequenceActor.java
//

#line 1 "/Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/modules/updates/SequenceActor.java"

#include "IOSObjectArray.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/DifferenceUpdate.h"
#include "im/actor/model/api/base/FatSeqUpdate.h"
#include "im/actor/model/api/base/SeqUpdate.h"
#include "im/actor/model/api/base/SeqUpdateTooLong.h"
#include "im/actor/model/api/base/WeakUpdate.h"
#include "im/actor/model/api/parser/UpdatesParser.h"
#include "im/actor/model/api/rpc/RequestGetDifference.h"
#include "im/actor/model/api/rpc/RequestGetState.h"
#include "im/actor/model/api/rpc/ResponseGetDifference.h"
#include "im/actor/model/api/rpc/ResponseSeq.h"
#include "im/actor/model/droidkit/actors/Actor.h"
#include "im/actor/model/droidkit/actors/ActorRef.h"
#include "im/actor/model/droidkit/engine/PreferencesStorage.h"
#include "im/actor/model/log/Log.h"
#include "im/actor/model/modules/Modules.h"
#include "im/actor/model/modules/updates/SequenceActor.h"
#include "im/actor/model/modules/updates/UpdateProcessor.h"
#include "im/actor/model/modules/updates/internal/ExecuteAfter.h"
#include "im/actor/model/modules/updates/internal/InternalUpdate.h"
#include "im/actor/model/modules/utils/ModuleActor.h"
#include "im/actor/model/network/RpcException.h"
#include "im/actor/model/network/parser/Update.h"
#include "java/io/IOException.h"
#include "java/lang/Integer.h"
#include "java/lang/Runnable.h"
#include "java/util/ArrayList.h"
#include "java/util/HashMap.h"
#include "java/util/List.h"

__attribute__((unused)) static void ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(ImActorModelModulesUpdatesSequenceActor *self, id u);
__attribute__((unused)) static jboolean ImActorModelModulesUpdatesSequenceActor_isValidSeqWithInt_(ImActorModelModulesUpdatesSequenceActor *self, jint seq);
__attribute__((unused)) static void ImActorModelModulesUpdatesSequenceActor_invalidate(ImActorModelModulesUpdatesSequenceActor *self);
__attribute__((unused)) static void ImActorModelModulesUpdatesSequenceActor_checkFuture(ImActorModelModulesUpdatesSequenceActor *self);
__attribute__((unused)) static void ImActorModelModulesUpdatesSequenceActor_checkRunnables(ImActorModelModulesUpdatesSequenceActor *self);

@interface ImActorModelModulesUpdatesSequenceActor () {
 @public
  JavaUtilHashMap *further_;
  JavaUtilArrayList *pendingRunnables_;
  jboolean isValidated_;
  jint seq_;
  IOSByteArray *state_;
  ImActorModelModulesUpdatesUpdateProcessor *processor_;
  ImActorModelApiParserUpdatesParser *parser_;
}

- (void)onUpdateReceivedWithId:(id)u;

- (jboolean)isValidSeqWithInt:(jint)seq;

- (void)invalidate;

- (void)checkFuture;

- (void)checkRunnables;
@end

J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor, further_, JavaUtilHashMap *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor, pendingRunnables_, JavaUtilArrayList *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor, state_, IOSByteArray *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor, processor_, ImActorModelModulesUpdatesUpdateProcessor *)
J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor, parser_, ImActorModelApiParserUpdatesParser *)

@interface ImActorModelModulesUpdatesSequenceActor_PushSeq () {
 @public
  jint seq_;
}
@end

@interface ImActorModelModulesUpdatesSequenceActor_$1 () {
 @public
  ImActorModelModulesUpdatesSequenceActor *this$0_;
}
@end

J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor_$1, this$0_, ImActorModelModulesUpdatesSequenceActor *)

@interface ImActorModelModulesUpdatesSequenceActor_$2 () {
 @public
  ImActorModelModulesUpdatesSequenceActor *this$0_;
}
@end

J2OBJC_FIELD_SETTER(ImActorModelModulesUpdatesSequenceActor_$2, this$0_, ImActorModelModulesUpdatesSequenceActor *)


#line 31
@implementation ImActorModelModulesUpdatesSequenceActor

NSString * ImActorModelModulesUpdatesSequenceActor_TAG_ = @"Updates";
NSString * ImActorModelModulesUpdatesSequenceActor_KEY_SEQ_ = 
#line 36
@"updates_seq";
NSString * ImActorModelModulesUpdatesSequenceActor_KEY_STATE_ = @"updates_state";


#line 50
- (instancetype)initWithImActorModelModulesModules:(ImActorModelModulesModules *)modules {
  if (self =
#line 51
  [super initWithImActorModelModulesModules:modules]) {
    further_ =
#line 39
    [[JavaUtilHashMap alloc] init];
    pendingRunnables_ =
#line 41
    [[JavaUtilArrayList alloc] init];
    isValidated_ =
#line 43
    YES;
  }
  return self;
}


#line 55
- (void)preStart {
  
#line 56
  seq_ = [((id<DKPreferencesStorage>) nil_chk([self preferences])) getInt:ImActorModelModulesUpdatesSequenceActor_KEY_SEQ_ withDefault:-1];
  state_ = [((id<DKPreferencesStorage>) nil_chk([self preferences])) getBytes:ImActorModelModulesUpdatesSequenceActor_KEY_STATE_];
  parser_ = [[ImActorModelApiParserUpdatesParser alloc] init];
  processor_ = [[ImActorModelModulesUpdatesUpdateProcessor alloc] initWithImActorModelModulesModules:[self modules]];
  
#line 61
  [((DKActorRef *) nil_chk([self self__])) sendWithId:[[ImActorModelModulesUpdatesSequenceActor_Invalidate alloc] init]];
}


#line 65
- (void)onReceiveWithId:(id)message {
  
#line 66
  if ([message isKindOfClass:[ImActorModelModulesUpdatesSequenceActor_Invalidate class]] || [message isKindOfClass:[ImActorModelApiBaseSeqUpdateTooLong class]] ||
#line 67
  [message isKindOfClass:[ImActorModelModulesUpdatesSequenceActor_ForceInvalidate class]]) {
    ImActorModelModulesUpdatesSequenceActor_invalidate(self);
  }
  else
#line 69
  if ([message isKindOfClass:[ImActorModelApiBaseSeqUpdate class]]) {
    ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(self, message);
  }
  else
#line 71
  if ([message isKindOfClass:[ImActorModelApiBaseFatSeqUpdate class]]) {
    ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(self, message);
  }
  else
#line 73
  if ([message isKindOfClass:[ImActorModelApiBaseWeakUpdate class]]) {
    ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(self, message);
  }
  else
#line 75
  if ([message isKindOfClass:[ImActorModelModulesUpdatesInternalInternalUpdate class]]) {
    ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(self, message);
  }
  else
#line 77
  if ([message isKindOfClass:[ImActorModelModulesUpdatesInternalExecuteAfter class]]) {
    ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(self, message);
  }
  else {
    
#line 80
    [self dropWithId:message];
  }
}


#line 84
- (void)onUpdateReceivedWithId:(id)u {
  ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(self, u);
}


#line 190
- (jboolean)isValidSeqWithInt:(jint)seq {
  return ImActorModelModulesUpdatesSequenceActor_isValidSeqWithInt_(self, seq);
}

- (void)invalidate {
  ImActorModelModulesUpdatesSequenceActor_invalidate(self);
}


#line 293
- (void)checkFuture {
  ImActorModelModulesUpdatesSequenceActor_checkFuture(self);
}


#line 304
- (void)checkRunnables {
  ImActorModelModulesUpdatesSequenceActor_checkRunnables(self);
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesSequenceActor *)other {
  [super copyAllFieldsTo:other];
  other->further_ = further_;
  other->pendingRunnables_ = pendingRunnables_;
  other->isValidated_ = isValidated_;
  other->seq_ = seq_;
  other->state_ = state_;
  other->processor_ = processor_;
  other->parser_ = parser_;
}

@end

void ImActorModelModulesUpdatesSequenceActor_onUpdateReceivedWithId_(ImActorModelModulesUpdatesSequenceActor *self, id u) {
  
#line 86
  jint seq;
  IOSByteArray *state;
  jint type;
  IOSByteArray *body;
  if ([u isKindOfClass:[ImActorModelApiBaseSeqUpdate class]]) {
    seq = [((ImActorModelApiBaseSeqUpdate *) nil_chk(((ImActorModelApiBaseSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseSeqUpdate class])))) getSeq];
    state = [((ImActorModelApiBaseSeqUpdate *) nil_chk(((ImActorModelApiBaseSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseSeqUpdate class])))) getState];
    type = [((ImActorModelApiBaseSeqUpdate *) nil_chk(((ImActorModelApiBaseSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseSeqUpdate class])))) getUpdateHeader];
    body = [((ImActorModelApiBaseSeqUpdate *) nil_chk(((ImActorModelApiBaseSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseSeqUpdate class])))) getUpdate];
  }
  else
#line 95
  if ([u isKindOfClass:[ImActorModelApiBaseFatSeqUpdate class]]) {
    seq = [((ImActorModelApiBaseFatSeqUpdate *) nil_chk(((ImActorModelApiBaseFatSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseFatSeqUpdate class])))) getSeq];
    state = [((ImActorModelApiBaseFatSeqUpdate *) nil_chk(((ImActorModelApiBaseFatSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseFatSeqUpdate class])))) getState];
    type = [((ImActorModelApiBaseFatSeqUpdate *) nil_chk(((ImActorModelApiBaseFatSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseFatSeqUpdate class])))) getUpdateHeader];
    body = [((ImActorModelApiBaseFatSeqUpdate *) nil_chk(((ImActorModelApiBaseFatSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseFatSeqUpdate class])))) getUpdate];
  }
  else
#line 100
  if ([u isKindOfClass:[ImActorModelApiBaseWeakUpdate class]]) {
    ImActorModelApiBaseWeakUpdate *w = (ImActorModelApiBaseWeakUpdate *) check_class_cast(u, [ImActorModelApiBaseWeakUpdate class]);
    AMLog_wWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Received weak update");
    @try {
      [((ImActorModelModulesUpdatesUpdateProcessor *) nil_chk(self->processor_)) processUpdateWithImActorModelNetworkParserUpdate:[((ImActorModelApiParserUpdatesParser *) nil_chk(self->parser_)) readWithInt:[((ImActorModelApiBaseWeakUpdate *) nil_chk(w)) getUpdateHeader] withByteArray:[w getUpdate]]];
    }
    @catch (
#line 105
    JavaIoIOException *e) {
      [((JavaIoIOException *) nil_chk(e)) printStackTrace];
      AMLog_wWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Unable to parse update: ignoring");
    }
    return;
  }
  else
#line 110
  if ([u isKindOfClass:[ImActorModelModulesUpdatesInternalInternalUpdate class]]) {
    AMLog_wWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Received internal update");
    [((ImActorModelModulesUpdatesUpdateProcessor *) nil_chk(self->processor_)) processInternalUpdateWithImActorModelModulesUpdatesInternalInternalUpdate:(ImActorModelModulesUpdatesInternalInternalUpdate *) check_class_cast(u, [ImActorModelModulesUpdatesInternalInternalUpdate class])];
    return;
  }
  else
#line 114
  if ([u isKindOfClass:[ImActorModelModulesUpdatesInternalExecuteAfter class]]) {
    ImActorModelModulesUpdatesInternalExecuteAfter *after = (ImActorModelModulesUpdatesInternalExecuteAfter *) check_class_cast(u, [ImActorModelModulesUpdatesInternalExecuteAfter class]);
    if ([((ImActorModelModulesUpdatesInternalExecuteAfter *) nil_chk(after)) getSeq] <= self->seq_) {
      [((id<JavaLangRunnable>) nil_chk([after getRunnable])) run];
    }
    else {
      
#line 119
      [((JavaUtilArrayList *) nil_chk(self->pendingRunnables_)) addWithId:after];
    }
    return;
  }
  else {
    
#line 123
    return;
  }
  
#line 127
  if (seq <= self->seq_) {
    AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, JreStrcat("$IC", @"Ignored SeqUpdate {seq:", seq, '}'));
    return;
  }
  AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, JreStrcat("$IC", @"SeqUpdate {seq:", seq, '}'));
  
#line 133
  if (!self->isValidated_) {
    AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Caching in further map");
    (void) [((JavaUtilHashMap *) nil_chk(self->further_)) putWithId:JavaLangInteger_valueOfWithInt_(seq) withId:u];
    return;
  }
  
#line 139
  if (!ImActorModelModulesUpdatesSequenceActor_isValidSeqWithInt_(self, seq)) {
    AMLog_wWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Out of sequence: starting timer for invalidation");
    (void) [((JavaUtilHashMap *) nil_chk(self->further_)) putWithId:JavaLangInteger_valueOfWithInt_(seq) withId:u];
    [((DKActorRef *) nil_chk([self self__])) sendOnceWithId:[[ImActorModelModulesUpdatesSequenceActor_ForceInvalidate alloc] init] withLong:ImActorModelModulesUpdatesSequenceActor_INVALIDATE_GAP];
    return;
  }
  
#line 147
  ImActorModelNetworkParserUpdate *update;
  @try {
    update = [((ImActorModelApiParserUpdatesParser *) [[ImActorModelApiParserUpdatesParser alloc] init]) readWithInt:type withByteArray:body];
  }
  @catch (
#line 150
  JavaIoIOException *e) {
    AMLog_wWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Unable to parse update: ignoring");
    [((JavaIoIOException *) nil_chk(e)) printStackTrace];
    return;
  }
  
#line 156
  if ([((ImActorModelModulesUpdatesUpdateProcessor *) nil_chk(self->processor_)) isCausesInvalidationWithImActorModelNetworkParserUpdate:update]) {
    AMLog_wWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Message causes invalidation");
    ImActorModelModulesUpdatesSequenceActor_invalidate(self);
    return;
  }
  
#line 163
  AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, JreStrcat("$@", @"Processing update: ", update));
  
#line 165
  if ([u isKindOfClass:[ImActorModelApiBaseFatSeqUpdate class]]) {
    ImActorModelApiBaseFatSeqUpdate *fatSeqUpdate = (ImActorModelApiBaseFatSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseFatSeqUpdate class]);
    [self->processor_ applyRelatedWithJavaUtilList:[((ImActorModelApiBaseFatSeqUpdate *) nil_chk(fatSeqUpdate)) getUsers] withJavaUtilList:[fatSeqUpdate getGroups] withBoolean:NO];
  }
  
#line 170
  [self->processor_ processUpdateWithImActorModelNetworkParserUpdate:update];
  
#line 172
  if ([u isKindOfClass:[ImActorModelApiBaseFatSeqUpdate class]]) {
    ImActorModelApiBaseFatSeqUpdate *fatSeqUpdate = (ImActorModelApiBaseFatSeqUpdate *) check_class_cast(u, [ImActorModelApiBaseFatSeqUpdate class]);
    [self->processor_ applyRelatedWithJavaUtilList:[((ImActorModelApiBaseFatSeqUpdate *) nil_chk(fatSeqUpdate)) getUsers] withJavaUtilList:[fatSeqUpdate getGroups] withBoolean:YES];
  }
  
#line 178
  self->seq_ = seq;
  self->state_ = state;
  [((id<DKPreferencesStorage>) nil_chk([self preferences])) putInt:ImActorModelModulesUpdatesSequenceActor_KEY_SEQ_ withValue:seq];
  [((id<DKPreferencesStorage>) nil_chk([self preferences])) putBytes:ImActorModelModulesUpdatesSequenceActor_KEY_STATE_ withValue:state];
  
#line 183
  ImActorModelModulesUpdatesSequenceActor_checkRunnables(self);
  ImActorModelModulesUpdatesSequenceActor_checkFuture(self);
  
#line 187
  [((DKActorRef *) nil_chk([self self__])) sendOnceWithId:[[ImActorModelModulesUpdatesSequenceActor_ForceInvalidate alloc] init] withLong:24 * 60 * 60 * 1000LL];
}

jboolean ImActorModelModulesUpdatesSequenceActor_isValidSeqWithInt_(ImActorModelModulesUpdatesSequenceActor *self, jint seq) {
  
#line 191
  return self->seq_ <= 0 || seq == self->seq_ + 1;
}

void ImActorModelModulesUpdatesSequenceActor_invalidate(ImActorModelModulesUpdatesSequenceActor *self) {
  
#line 195
  if (!self->isValidated_) {
    return;
  }
  self->isValidated_ = NO;
  
#line 200
  if (self->seq_ < 0) {
    AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Loading fresh state...");
    [self requestWithImActorModelNetworkParserRequest:[[ImActorModelApiRpcRequestGetState alloc] init] withAMRpcCallback:[[ImActorModelModulesUpdatesSequenceActor_$1 alloc] initWithImActorModelModulesUpdatesSequenceActor:self]];
  }
  else {
    
#line 237
    AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_TAG_, @"Loading difference...");
    [self requestWithImActorModelNetworkParserRequest:[[ImActorModelApiRpcRequestGetDifference alloc] initWithInt:self->seq_ withByteArray:self->state_] withAMRpcCallback:[[ImActorModelModulesUpdatesSequenceActor_$2 alloc] initWithImActorModelModulesUpdatesSequenceActor:self]];
  }
}

void ImActorModelModulesUpdatesSequenceActor_checkFuture(ImActorModelModulesUpdatesSequenceActor *self) {
  
#line 294
  for (jint i = self->seq_ + 1; ; i++) {
    if ([((JavaUtilHashMap *) nil_chk(self->further_)) containsKeyWithId:JavaLangInteger_valueOfWithInt_(i)]) {
      [self onReceiveWithId:[self->further_ removeWithId:JavaLangInteger_valueOfWithInt_(i)]];
    }
    else {
      
#line 298
      break;
    }
  }
  [((JavaUtilHashMap *) nil_chk(self->further_)) clear];
}

void ImActorModelModulesUpdatesSequenceActor_checkRunnables(ImActorModelModulesUpdatesSequenceActor *self) {
  
#line 305
  if ([((JavaUtilArrayList *) nil_chk(self->pendingRunnables_)) size] > 0) {
    {
      IOSObjectArray *a__ =
#line 306
      [self->pendingRunnables_ toArrayWithNSObjectArray:[IOSObjectArray newArrayWithLength:[self->pendingRunnables_ size] type:ImActorModelModulesUpdatesInternalExecuteAfter_class_()]];
      ImActorModelModulesUpdatesInternalExecuteAfter * const *b__ = ((IOSObjectArray *) nil_chk(a__))->buffer_;
      ImActorModelModulesUpdatesInternalExecuteAfter * const *e__ = b__ + a__->size_;
      while (b__ < e__) {
        ImActorModelModulesUpdatesInternalExecuteAfter *e = *b__++;
        
#line 307
        if ([((ImActorModelModulesUpdatesInternalExecuteAfter *) nil_chk(e)) getSeq] <= self->seq_) {
          [((id<JavaLangRunnable>) nil_chk([e getRunnable])) run];
          [self->pendingRunnables_ removeWithId:e];
        }
      }
    }
  }
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesSequenceActor)


#line 315
@implementation ImActorModelModulesUpdatesSequenceActor_ForceInvalidate

- (instancetype)init {
  return [super init];
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesSequenceActor_ForceInvalidate)


#line 319
@implementation ImActorModelModulesUpdatesSequenceActor_Invalidate

- (instancetype)init {
  return [super init];
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesSequenceActor_Invalidate)


#line 323
@implementation ImActorModelModulesUpdatesSequenceActor_PushSeq


#line 326
- (instancetype)initWithInt:(jint)seq {
  if (self = [super init]) {
    
#line 327
    self->seq_ = seq;
  }
  return self;
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesSequenceActor_PushSeq *)other {
  [super copyAllFieldsTo:other];
  other->seq_ = seq_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesSequenceActor_PushSeq)

@implementation ImActorModelModulesUpdatesSequenceActor_$1


#line 204
- (void)onResultWithImActorModelNetworkParserResponse:(ImActorModelApiRpcResponseSeq *)response {
  
#line 205
  if (this$0_->isValidated_) {
    return;
  }
  
#line 209
  this$0_->seq_ = [((ImActorModelApiRpcResponseSeq *) nil_chk(response)) getSeq];
  this$0_->state_ = [response getState];
  
#line 212
  this$0_->isValidated_ = YES;
  
#line 214
  [((id<DKPreferencesStorage>) nil_chk([this$0_ preferences])) putInt:ImActorModelModulesUpdatesSequenceActor_get_KEY_SEQ_() withValue:this$0_->seq_];
  [((id<DKPreferencesStorage>) nil_chk([this$0_ preferences])) putBytes:ImActorModelModulesUpdatesSequenceActor_get_KEY_STATE_() withValue:this$0_->state_];
  
#line 217
  AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_get_TAG_(), JreStrcat("$IC", @"State loaded {seq=", this$0_->seq_, '}'));
  
#line 219
  ImActorModelModulesUpdatesSequenceActor_checkRunnables(this$0_);
  ImActorModelModulesUpdatesSequenceActor_checkFuture(this$0_);
  
#line 223
  [((DKActorRef *) nil_chk([this$0_ self__])) sendOnceWithId:[[ImActorModelModulesUpdatesSequenceActor_ForceInvalidate alloc] init] withLong:24 * 60 * 60 * 1000LL];
}


#line 227
- (void)onErrorWithAMRpcException:(AMRpcException *)e {
  
#line 228
  if (this$0_->isValidated_) {
    return;
  }
  this$0_->isValidated_ = YES;
  
#line 233
  ImActorModelModulesUpdatesSequenceActor_invalidate(this$0_);
}

- (instancetype)initWithImActorModelModulesUpdatesSequenceActor:(ImActorModelModulesUpdatesSequenceActor *)outer$ {
  this$0_ = outer$;
  return [super init];
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesSequenceActor_$1 *)other {
  [super copyAllFieldsTo:other];
  other->this$0_ = this$0_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesSequenceActor_$1)

@implementation ImActorModelModulesUpdatesSequenceActor_$2


#line 240
- (void)onResultWithImActorModelNetworkParserResponse:(ImActorModelApiRpcResponseGetDifference *)response {
  
#line 241
  if (this$0_->isValidated_) {
    return;
  }
  
#line 245
  AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_get_TAG_(), JreStrcat("$IC", @"Difference loaded {seq=", [((ImActorModelApiRpcResponseGetDifference *) nil_chk(response)) getSeq], '}'));
  
#line 247
  [((ImActorModelModulesUpdatesUpdateProcessor *) nil_chk(this$0_->processor_)) applyRelatedWithJavaUtilList:[response getUsers] withJavaUtilList:[response getGroups] withBoolean:NO];
  for (ImActorModelApiDifferenceUpdate * __strong u in nil_chk([response getUpdates])) {
    @try {
      ImActorModelNetworkParserUpdate *update = [((ImActorModelApiParserUpdatesParser *) nil_chk(this$0_->parser_)) readWithInt:[((ImActorModelApiDifferenceUpdate *) nil_chk(u)) getUpdateHeader] withByteArray:[u getUpdate]];
      [this$0_->processor_ processUpdateWithImActorModelNetworkParserUpdate:update];
    }
    @catch (
#line 252
    JavaIoIOException *e) {
      [((JavaIoIOException *) nil_chk(e)) printStackTrace];
      AMLog_dWithNSString_withNSString_(ImActorModelModulesUpdatesSequenceActor_get_TAG_(), JreStrcat("$I$", @"Broken update #", [((ImActorModelApiDifferenceUpdate *) nil_chk(u)) getUpdateHeader], @": ignoring"));
    }
  }
  [this$0_->processor_ applyRelatedWithJavaUtilList:[response getUsers] withJavaUtilList:[response getGroups] withBoolean:YES];
  
#line 259
  this$0_->seq_ = [response getSeq];
  this$0_->state_ = [response getState];
  
#line 262
  this$0_->isValidated_ = YES;
  
#line 264
  [((id<DKPreferencesStorage>) nil_chk([this$0_ preferences])) putInt:ImActorModelModulesUpdatesSequenceActor_get_KEY_SEQ_() withValue:this$0_->seq_];
  [((id<DKPreferencesStorage>) nil_chk([this$0_ preferences])) putBytes:ImActorModelModulesUpdatesSequenceActor_get_KEY_STATE_() withValue:this$0_->state_];
  
#line 267
  ImActorModelModulesUpdatesSequenceActor_checkRunnables(this$0_);
  ImActorModelModulesUpdatesSequenceActor_checkFuture(this$0_);
  
#line 271
  [((DKActorRef *) nil_chk([this$0_ self__])) sendOnceWithId:[[ImActorModelModulesUpdatesSequenceActor_ForceInvalidate alloc] init] withLong:24 * 60 * 60 * 1000LL];
  
#line 273
  if ([response needMore]) {
    ImActorModelModulesUpdatesSequenceActor_invalidate(this$0_);
  }
}


#line 279
- (void)onErrorWithAMRpcException:(AMRpcException *)e {
  
#line 280
  if (this$0_->isValidated_) {
    return;
  }
  this$0_->isValidated_ = YES;
  
#line 285
  ImActorModelModulesUpdatesSequenceActor_invalidate(this$0_);
}

- (instancetype)initWithImActorModelModulesUpdatesSequenceActor:(ImActorModelModulesUpdatesSequenceActor *)outer$ {
  this$0_ = outer$;
  return [super init];
}

- (void)copyAllFieldsTo:(ImActorModelModulesUpdatesSequenceActor_$2 *)other {
  [super copyAllFieldsTo:other];
  other->this$0_ = this$0_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelModulesUpdatesSequenceActor_$2)