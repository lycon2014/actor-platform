//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/mvvm/MVVMEngine.java
//


#include "J2ObjC_source.h"
#include "im/actor/model/MainThreadProvider.h"
#include "im/actor/model/mvvm/MVVMEngine.h"
#include "java/lang/Runnable.h"
#include "java/lang/RuntimeException.h"

static id<AMMainThreadProvider> AMMVVMEngine_mainThreadProvider_;
J2OBJC_STATIC_FIELD_GETTER(AMMVVMEngine, mainThreadProvider_, id<AMMainThreadProvider>)
J2OBJC_STATIC_FIELD_SETTER(AMMVVMEngine, mainThreadProvider_, id<AMMainThreadProvider>)

@implementation AMMVVMEngine

+ (void)init__WithAMMainThreadProvider:(id<AMMainThreadProvider>)mainThreadProvider {
  AMMVVMEngine_init__WithAMMainThreadProvider_(mainThreadProvider);
}

+ (id<AMMainThreadProvider>)getMainThreadProvider {
  return AMMVVMEngine_getMainThreadProvider();
}

+ (void)checkMainThread {
  AMMVVMEngine_checkMainThread();
}

+ (void)runOnUiThreadWithJavaLangRunnable:(id<JavaLangRunnable>)runnable {
  AMMVVMEngine_runOnUiThreadWithJavaLangRunnable_(runnable);
}

- (instancetype)init {
  AMMVVMEngine_init(self);
  return self;
}

@end

void AMMVVMEngine_init__WithAMMainThreadProvider_(id<AMMainThreadProvider> mainThreadProvider) {
  AMMVVMEngine_initialize();
  AMMVVMEngine_mainThreadProvider_ = mainThreadProvider;
}

id<AMMainThreadProvider> AMMVVMEngine_getMainThreadProvider() {
  AMMVVMEngine_initialize();
  return AMMVVMEngine_mainThreadProvider_;
}

void AMMVVMEngine_checkMainThread() {
  AMMVVMEngine_initialize();
  if ([((id<AMMainThreadProvider>) nil_chk(AMMVVMEngine_mainThreadProvider_)) isSingleThread]) {
    return;
  }
  if (![AMMVVMEngine_mainThreadProvider_ isMainThread]) {
    @throw new_JavaLangRuntimeException_initWithNSString_(@"Unable to perform operation not from Main Thread");
  }
}

void AMMVVMEngine_runOnUiThreadWithJavaLangRunnable_(id<JavaLangRunnable> runnable) {
  AMMVVMEngine_initialize();
  [((id<AMMainThreadProvider>) nil_chk(AMMVVMEngine_mainThreadProvider_)) postToMainThreadWithRunnable:runnable];
}

void AMMVVMEngine_init(AMMVVMEngine *self) {
  (void) NSObject_init(self);
}

AMMVVMEngine *new_AMMVVMEngine_init() {
  AMMVVMEngine *self = [AMMVVMEngine alloc];
  AMMVVMEngine_init(self);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(AMMVVMEngine)