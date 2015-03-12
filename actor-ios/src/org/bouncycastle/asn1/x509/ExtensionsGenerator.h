//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/asn1/x509/ExtensionsGenerator.java
//

#ifndef _OrgBouncycastleAsn1X509ExtensionsGenerator_H_
#define _OrgBouncycastleAsn1X509ExtensionsGenerator_H_

@class IOSByteArray;
@class JavaUtilHashtable;
@class JavaUtilVector;
@class OrgBouncycastleAsn1ASN1ObjectIdentifier;
@class OrgBouncycastleAsn1X509Extensions;
@protocol OrgBouncycastleAsn1ASN1Encodable;

#include "J2ObjC_header.h"

@interface OrgBouncycastleAsn1X509ExtensionsGenerator : NSObject {
}

- (void)reset;

- (void)addExtensionWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid
                                                    withBoolean:(jboolean)critical
                           withOrgBouncycastleAsn1ASN1Encodable:(id<OrgBouncycastleAsn1ASN1Encodable>)value;

- (void)addExtensionWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid
                                                    withBoolean:(jboolean)critical
                                                  withByteArray:(IOSByteArray *)value;

- (jboolean)isEmpty;

- (OrgBouncycastleAsn1X509Extensions *)generate;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleAsn1X509ExtensionsGenerator)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1X509ExtensionsGenerator)

#endif // _OrgBouncycastleAsn1X509ExtensionsGenerator_H_