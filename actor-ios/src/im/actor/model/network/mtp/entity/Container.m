//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/im/actor/model/network/mtp/entity/Container.java
//

#include "IOSClass.h"
#include "IOSObjectArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/network/mtp/entity/Container.h"
#include "im/actor/model/network/mtp/entity/ProtoMessage.h"
#include "im/actor/model/util/DataInput.h"
#include "im/actor/model/util/DataOutput.h"
#include "java/io/IOException.h"

@interface MTContainer () {
 @public
  IOSObjectArray *messages_;
}
@end

J2OBJC_FIELD_SETTER(MTContainer, messages_, IOSObjectArray *)

@implementation MTContainer

- (instancetype)initWithAMDataInput:(AMDataInput *)stream {
  return [super initWithAMDataInput:stream];
}

- (instancetype)initWithMTProtoMessageArray:(IOSObjectArray *)messages {
  if (self = [super init]) {
    self->messages_ = messages;
  }
  return self;
}

- (IOSObjectArray *)getMessages {
  return messages_;
}

- (jbyte)getHeader {
  return MTContainer_HEADER;
}

- (void)writeBodyWithAMDataOutput:(AMDataOutput *)bs {
  if (messages_ != nil && messages_->size_ > 0) {
    [((AMDataOutput *) nil_chk(bs)) writeVarIntWithLong:messages_->size_];
    {
      IOSObjectArray *a__ = messages_;
      MTProtoMessage * const *b__ = a__->buffer_;
      MTProtoMessage * const *e__ = b__ + a__->size_;
      while (b__ < e__) {
        MTProtoMessage *m = *b__++;
        [((MTProtoMessage *) nil_chk(m)) writeObjectWithAMDataOutput:bs];
      }
    }
  }
  else {
    [((AMDataOutput *) nil_chk(bs)) writeVarIntWithLong:0];
  }
}

- (void)readBodyWithAMDataInput:(AMDataInput *)bs {
  jint size = (jint) [((AMDataInput *) nil_chk(bs)) readVarInt];
  messages_ = [IOSObjectArray newArrayWithLength:size type:MTProtoMessage_class_()];
  for (jint i = 0; i < size; ++i) {
    IOSObjectArray_SetAndConsume(messages_, i, [[MTProtoMessage alloc] initWithAMDataInput:bs]);
  }
}

- (NSString *)description {
  return JreStrcat("$I$", @"Conatiner[", ((IOSObjectArray *) nil_chk(messages_))->size_, @" items]");
}

- (void)copyAllFieldsTo:(MTContainer *)other {
  [super copyAllFieldsTo:other];
  other->messages_ = messages_;
}

+ (const J2ObjcClassInfo *)__metadata {
  static const J2ObjcMethodInfo methods[] = {
    { "initWithAMDataInput:", "Container", NULL, 0x1, "Ljava.io.IOException;" },
    { "initWithMTProtoMessageArray:", "Container", NULL, 0x1, NULL },
    { "getMessages", NULL, "[Lim.actor.model.network.mtp.entity.ProtoMessage;", 0x1, NULL },
    { "getHeader", NULL, "B", 0x4, NULL },
    { "writeBodyWithAMDataOutput:", "writeBody", "V", 0x4, "Ljava.io.IOException;" },
    { "readBodyWithAMDataInput:", "readBody", "V", 0x4, "Ljava.io.IOException;" },
    { "description", "toString", "Ljava.lang.String;", 0x1, NULL },
  };
  static const J2ObjcFieldInfo fields[] = {
    { "HEADER_", NULL, 0x19, "B", NULL, .constantValue.asChar = MTContainer_HEADER },
    { "messages_", NULL, 0x2, "[Lim.actor.model.network.mtp.entity.ProtoMessage;", NULL,  },
  };
  static const J2ObjcClassInfo _MTContainer = { 1, "Container", "im.actor.model.network.mtp.entity", NULL, 0x1, 7, methods, 2, fields, 0, NULL};
  return &_MTContainer;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(MTContainer)