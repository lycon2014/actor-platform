//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/library/actor-cocoa-base/build/java/im/actor/model/Configuration.java
//

#ifndef _AMConfiguration_H_
#define _AMConfiguration_H_

@class AMApiConfiguration;
@class IOSObjectArray;
@protocol AMCryptoProvider;
@protocol AMDispatcherProvider;
@protocol AMFileSystemProvider;
@protocol AMHttpDownloaderProvider;
@protocol AMLocaleProvider;
@protocol AMLogProvider;
@protocol AMMainThreadProvider;
@protocol AMNetworkProvider;
@protocol AMNotificationProvider;
@protocol AMPhoneBookProvider;
@protocol AMStorageProvider;
@protocol AMThreadingProvider;

#include "J2ObjC_header.h"

@interface AMConfiguration : NSObject {
}

- (instancetype)initWithAMNetworkProvider:(id<AMNetworkProvider>)networkProvider
            withAMConnectionEndpointArray:(IOSObjectArray *)endpoints
                  withAMThreadingProvider:(id<AMThreadingProvider>)threadingProvider
                 withAMMainThreadProvider:(id<AMMainThreadProvider>)mainThreadProvider
                    withAMStorageProvider:(id<AMStorageProvider>)storageProvider
                        withAMLogProvider:(id<AMLogProvider>)log
                     withAMLocaleProvider:(id<AMLocaleProvider>)localeProvider
                  withAMPhoneBookProvider:(id<AMPhoneBookProvider>)phoneBookProvider
                     withAMCryptoProvider:(id<AMCryptoProvider>)cryptoProvider
                 withAMFileSystemProvider:(id<AMFileSystemProvider>)fileSystemProvider
               withAMNotificationProvider:(id<AMNotificationProvider>)notificationProvider
                 withAMDispatcherProvider:(id<AMDispatcherProvider>)dispatcherProvider
                   withAMApiConfiguration:(AMApiConfiguration *)apiConfiguration
                              withBoolean:(jboolean)enableContactsLogging
                              withBoolean:(jboolean)enableNetworkLogging
                              withBoolean:(jboolean)enableFilesLogging
             withAMHttpDownloaderProvider:(id<AMHttpDownloaderProvider>)httpDownloaderProvider;

- (AMApiConfiguration *)getApiConfiguration;

- (id<AMNotificationProvider>)getNotificationProvider;

- (jboolean)isEnableContactsLogging;

- (jboolean)isEnableNetworkLogging;

- (jboolean)isEnableFilesLogging;

- (id<AMCryptoProvider>)getCryptoProvider;

- (id<AMPhoneBookProvider>)getPhoneBookProvider;

- (id<AMNetworkProvider>)getNetworkProvider;

- (IOSObjectArray *)getEndpoints;

- (id<AMThreadingProvider>)getThreadingProvider;

- (id<AMMainThreadProvider>)getMainThreadProvider;

- (id<AMStorageProvider>)getStorageProvider;

- (id<AMLogProvider>)getLog;

- (id<AMLocaleProvider>)getLocaleProvider;

- (id<AMFileSystemProvider>)getFileSystemProvider;

- (id<AMDispatcherProvider>)getDispatcherProvider;

- (id<AMHttpDownloaderProvider>)getHttpDownloaderProvider;

@end

J2OBJC_EMPTY_STATIC_INIT(AMConfiguration)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

typedef AMConfiguration ImActorModelConfiguration;

J2OBJC_TYPE_LITERAL_HEADER(AMConfiguration)

#endif // _AMConfiguration_H_
