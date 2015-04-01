//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/OutPeer.java
//

#line 1 "/Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/api/OutPeer.java"

#include "IOSClass.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/OutPeer.h"
#include "im/actor/model/api/PeerType.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "java/io/IOException.h"

@interface ImActorModelApiOutPeer () {
 @public
  ImActorModelApiPeerTypeEnum *type_;
  jint id__;
  jlong accessHash_;
}
@end

J2OBJC_FIELD_SETTER(ImActorModelApiOutPeer, type_, ImActorModelApiPeerTypeEnum *)


#line 19
@implementation ImActorModelApiOutPeer


#line 25
- (instancetype)initWithImActorModelApiPeerTypeEnum:(ImActorModelApiPeerTypeEnum *)type
                                            withInt:(jint)id_
                                           withLong:(jlong)accessHash {
  if (self = [super init]) {
    
#line 26
    self->type_ = type;
    
#line 27
    self->id__ = id_;
    
#line 28
    self->accessHash_ = accessHash;
  }
  return self;
}


#line 31
- (instancetype)init {
  return [super init];
}

- (ImActorModelApiPeerTypeEnum *)getType {
  
#line 36
  return self->type_;
}


#line 39
- (jint)getId {
  
#line 40
  return self->id__;
}


#line 43
- (jlong)getAccessHash {
  
#line 44
  return self->accessHash_;
}


#line 48
- (void)parseWithBSBserValues:(BSBserValues *)values {
  self->type_ = ImActorModelApiPeerTypeEnum_parseWithInt_([((BSBserValues *) nil_chk(values)) getIntWithInt:1]);
  self->id__ = [values getIntWithInt:2];
  self->accessHash_ = [values getLongWithInt:3];
}


#line 55
- (void)serializeWithBSBserWriter:(BSBserWriter *)writer {
  
#line 56
  if (self->type_ == nil) {
    @throw [[JavaIoIOException alloc] init];
  }
  [((BSBserWriter *) nil_chk(writer)) writeIntWithInt:1 withInt:[((ImActorModelApiPeerTypeEnum *) nil_chk(self->type_)) getValue]];
  [writer writeIntWithInt:2 withInt:self->id__];
  [writer writeLongWithInt:3 withLong:self->accessHash_];
}

- (NSString *)description {
  NSString *res = @"struct OutPeer{";
  res = JreStrcat("$$", res, JreStrcat("$@", @"type=", self->type_));
  res = JreStrcat("$$", res, JreStrcat("$I", @", id=", self->id__));
  res = JreStrcat("$C", res, '}');
  return res;
}

- (void)copyAllFieldsTo:(ImActorModelApiOutPeer *)other {
  [super copyAllFieldsTo:other];
  other->type_ = type_;
  other->id__ = id__;
  other->accessHash_ = accessHash_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiOutPeer)