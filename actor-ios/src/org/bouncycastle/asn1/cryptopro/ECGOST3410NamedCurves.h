//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/asn1/cryptopro/ECGOST3410NamedCurves.java
//

#ifndef _OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_H_
#define _OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_H_

@class JavaUtilHashtable;
@class OrgBouncycastleAsn1ASN1ObjectIdentifier;
@class OrgBouncycastleCryptoParamsECDomainParameters;
@protocol JavaUtilEnumeration;

#include "J2ObjC_header.h"

@interface OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves : NSObject {
}

+ (OrgBouncycastleCryptoParamsECDomainParameters *)getByOIDWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid;

+ (id<JavaUtilEnumeration>)getNames;

+ (OrgBouncycastleCryptoParamsECDomainParameters *)getByNameWithNSString:(NSString *)name;

+ (NSString *)getNameWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid;

+ (OrgBouncycastleAsn1ASN1ObjectIdentifier *)getOIDWithNSString:(NSString *)name;

- (instancetype)init;

@end

FOUNDATION_EXPORT BOOL OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_initialized;
J2OBJC_STATIC_INIT(OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves)

CF_EXTERN_C_BEGIN

FOUNDATION_EXPORT OrgBouncycastleCryptoParamsECDomainParameters *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_getByOIDWithOrgBouncycastleAsn1ASN1ObjectIdentifier_(OrgBouncycastleAsn1ASN1ObjectIdentifier *oid);

FOUNDATION_EXPORT id<JavaUtilEnumeration> OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_getNames();

FOUNDATION_EXPORT OrgBouncycastleCryptoParamsECDomainParameters *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_getByNameWithNSString_(NSString *name);

FOUNDATION_EXPORT NSString *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_getNameWithOrgBouncycastleAsn1ASN1ObjectIdentifier_(OrgBouncycastleAsn1ASN1ObjectIdentifier *oid);

FOUNDATION_EXPORT OrgBouncycastleAsn1ASN1ObjectIdentifier *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_getOIDWithNSString_(NSString *name);

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_objIds_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves, objIds_, JavaUtilHashtable *)

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_params_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves, params_, JavaUtilHashtable *)

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_names_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves, names_, JavaUtilHashtable *)
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves)

#endif // _OrgBouncycastleAsn1CryptoproECGOST3410NamedCurves_H_