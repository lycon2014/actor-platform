//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/asn1/x509/CertificatePolicies.java
//

#ifndef _OrgBouncycastleAsn1X509CertificatePolicies_H_
#define _OrgBouncycastleAsn1X509CertificatePolicies_H_

@class IOSObjectArray;
@class OrgBouncycastleAsn1ASN1ObjectIdentifier;
@class OrgBouncycastleAsn1ASN1Primitive;
@class OrgBouncycastleAsn1ASN1Sequence;
@class OrgBouncycastleAsn1ASN1TaggedObject;
@class OrgBouncycastleAsn1X509Extensions;
@class OrgBouncycastleAsn1X509PolicyInformation;

#include "J2ObjC_header.h"
#include "org/bouncycastle/asn1/ASN1Object.h"

@interface OrgBouncycastleAsn1X509CertificatePolicies : OrgBouncycastleAsn1ASN1Object {
}

+ (OrgBouncycastleAsn1X509CertificatePolicies *)getInstanceWithId:(id)obj;

+ (OrgBouncycastleAsn1X509CertificatePolicies *)getInstanceWithOrgBouncycastleAsn1ASN1TaggedObject:(OrgBouncycastleAsn1ASN1TaggedObject *)obj
                                                                                       withBoolean:(jboolean)explicit_;

+ (OrgBouncycastleAsn1X509CertificatePolicies *)fromExtensionsWithOrgBouncycastleAsn1X509Extensions:(OrgBouncycastleAsn1X509Extensions *)extensions;

- (instancetype)initWithOrgBouncycastleAsn1X509PolicyInformation:(OrgBouncycastleAsn1X509PolicyInformation *)name;

- (instancetype)initWithOrgBouncycastleAsn1X509PolicyInformationArray:(IOSObjectArray *)policyInformation;

- (IOSObjectArray *)getPolicyInformation;

- (OrgBouncycastleAsn1X509PolicyInformation *)getPolicyInformationWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)policyIdentifier;

- (OrgBouncycastleAsn1ASN1Primitive *)toASN1Primitive;

- (NSString *)description;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleAsn1X509CertificatePolicies)

CF_EXTERN_C_BEGIN

FOUNDATION_EXPORT OrgBouncycastleAsn1X509CertificatePolicies *OrgBouncycastleAsn1X509CertificatePolicies_getInstanceWithId_(id obj);

FOUNDATION_EXPORT OrgBouncycastleAsn1X509CertificatePolicies *OrgBouncycastleAsn1X509CertificatePolicies_getInstanceWithOrgBouncycastleAsn1ASN1TaggedObject_withBoolean_(OrgBouncycastleAsn1ASN1TaggedObject *obj, jboolean explicit_);

FOUNDATION_EXPORT OrgBouncycastleAsn1X509CertificatePolicies *OrgBouncycastleAsn1X509CertificatePolicies_fromExtensionsWithOrgBouncycastleAsn1X509Extensions_(OrgBouncycastleAsn1X509Extensions *extensions);
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1X509CertificatePolicies)

#endif // _OrgBouncycastleAsn1X509CertificatePolicies_H_