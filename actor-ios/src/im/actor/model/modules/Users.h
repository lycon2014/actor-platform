//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/im/actor/model/modules/Users.java
//

#ifndef _ImActorModelModulesUsers_H_
#define _ImActorModelModulesUsers_H_

@class AMMessenger;
@protocol ImActorModelMvvmKeyValueEngine;

#include "J2ObjC_header.h"

@interface ImActorModelModulesUsers : NSObject {
}

- (instancetype)initWithAMMessenger:(AMMessenger *)messenger;

- (id<ImActorModelMvvmKeyValueEngine>)getUsers;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelModulesUsers)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelModulesUsers)

#endif // _ImActorModelModulesUsers_H_