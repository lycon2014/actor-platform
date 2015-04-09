//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/modules/SearchModule.java
//

#ifndef _ImActorModelModulesSearchModule_H_
#define _ImActorModelModulesSearchModule_H_

@class DKActorRef;
@class IOSObjectArray;
@class ImActorModelModulesModules;
@class ImActorModelModulesSearchSearchActor;
@protocol DKListEngine;
@protocol JavaUtilList;

#include "J2ObjC_header.h"
#include "im/actor/model/droidkit/actors/ActorCreator.h"
#include "im/actor/model/modules/BaseModule.h"

@interface ImActorModelModulesSearchModule : ImActorModelModulesBaseModule {
}

- (instancetype)initWithImActorModelModulesModules:(ImActorModelModulesModules *)modules;

- (void)run;

- (id<DKListEngine>)getSearchList;

- (void)onDialogsChangedWithJavaUtilList:(id<JavaUtilList>)dialogs;

- (void)onContactsChangedWithJavaLangIntegerArray:(IOSObjectArray *)contacts;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelModulesSearchModule)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelModulesSearchModule)

@interface ImActorModelModulesSearchModule_$1 : NSObject < DKActorCreator > {
}

- (ImActorModelModulesSearchSearchActor *)create;

- (instancetype)initWithImActorModelModulesSearchModule:(ImActorModelModulesSearchModule *)outer$;

@end

J2OBJC_EMPTY_STATIC_INIT(ImActorModelModulesSearchModule_$1)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(ImActorModelModulesSearchModule_$1)

#endif // _ImActorModelModulesSearchModule_H_