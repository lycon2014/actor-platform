//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/im/actor/model/api/rpc/RequestGetState.java
//

#include "IOSClass.h"
#include "IOSPrimitiveArray.h"
#include "J2ObjC_source.h"
#include "im/actor/model/api/rpc/RequestGetState.h"
#include "im/actor/model/droidkit/bser/Bser.h"
#include "im/actor/model/droidkit/bser/BserObject.h"
#include "im/actor/model/droidkit/bser/BserValues.h"
#include "im/actor/model/droidkit/bser/BserWriter.h"
#include "java/io/IOException.h"

@implementation ImActorModelApiRpcRequestGetState

+ (ImActorModelApiRpcRequestGetState *)fromBytesWithByteArray:(IOSByteArray *)data {
  return ImActorModelApiRpcRequestGetState_fromBytesWithByteArray_(data);
}

- (instancetype)init {
  return [super init];
}

- (void)parseWithImActorModelDroidkitBserBserValues:(ImActorModelDroidkitBserBserValues *)values {
}

- (void)serializeWithImActorModelDroidkitBserBserWriter:(ImActorModelDroidkitBserBserWriter *)writer {
}

- (jint)getHeaderKey {
  return ImActorModelApiRpcRequestGetState_HEADER;
}

+ (const J2ObjcClassInfo *)__metadata {
  static const J2ObjcMethodInfo methods[] = {
    { "fromBytesWithByteArray:", "fromBytes", "Lim.actor.model.api.rpc.RequestGetState;", 0x9, "Ljava.io.IOException;" },
    { "init", "RequestGetState", NULL, 0x1, NULL },
    { "parseWithImActorModelDroidkitBserBserValues:", "parse", "V", 0x1, "Ljava.io.IOException;" },
    { "serializeWithImActorModelDroidkitBserBserWriter:", "serialize", "V", 0x1, "Ljava.io.IOException;" },
    { "getHeaderKey", NULL, "I", 0x1, NULL },
  };
  static const J2ObjcFieldInfo fields[] = {
    { "HEADER_", NULL, 0x19, "I", NULL, .constantValue.asInt = ImActorModelApiRpcRequestGetState_HEADER },
  };
  static const char *superclass_type_args[] = {"Lim.actor.model.api.rpc.ResponseSeq;"};
  static const J2ObjcClassInfo _ImActorModelApiRpcRequestGetState = { 1, "RequestGetState", "im.actor.model.api.rpc", NULL, 0x1, 5, methods, 1, fields, 1, superclass_type_args};
  return &_ImActorModelApiRpcRequestGetState;
}

@end

ImActorModelApiRpcRequestGetState *ImActorModelApiRpcRequestGetState_fromBytesWithByteArray_(IOSByteArray *data) {
  ImActorModelApiRpcRequestGetState_init();
  return ((ImActorModelApiRpcRequestGetState *) ImActorModelDroidkitBserBser_parseWithImActorModelDroidkitBserBserObject_withByteArray_([[ImActorModelApiRpcRequestGetState alloc] init], data));
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(ImActorModelApiRpcRequestGetState)