//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/crypto/ec/CustomNamedCurves.java
//

#ifndef _OrgBouncycastleCryptoEcCustomNamedCurves_H_
#define _OrgBouncycastleCryptoEcCustomNamedCurves_H_

@class JavaUtilHashtable;
@class OrgBouncycastleAsn1ASN1ObjectIdentifier;
@class OrgBouncycastleAsn1X9X9ECParameters;
@class OrgBouncycastleMathEcECCurve;
@class OrgBouncycastleMathEcEndoGLVTypeBParameters;
@protocol JavaUtilEnumeration;

#include "J2ObjC_header.h"
#include "org/bouncycastle/asn1/x9/X9ECParametersHolder.h"

@interface OrgBouncycastleCryptoEcCustomNamedCurves : NSObject {
}

+ (void)defineCurveWithNSString:(NSString *)name
withOrgBouncycastleAsn1X9X9ECParametersHolder:(OrgBouncycastleAsn1X9X9ECParametersHolder *)holder;

+ (void)defineCurveWithOIDWithNSString:(NSString *)name
withOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid
withOrgBouncycastleAsn1X9X9ECParametersHolder:(OrgBouncycastleAsn1X9X9ECParametersHolder *)holder;

+ (void)defineCurveAliasWithNSString:(NSString *)alias
withOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid;

+ (OrgBouncycastleAsn1X9X9ECParameters *)getByNameWithNSString:(NSString *)name;

+ (OrgBouncycastleAsn1X9X9ECParameters *)getByOIDWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid;

+ (OrgBouncycastleAsn1ASN1ObjectIdentifier *)getOIDWithNSString:(NSString *)name;

+ (NSString *)getNameWithOrgBouncycastleAsn1ASN1ObjectIdentifier:(OrgBouncycastleAsn1ASN1ObjectIdentifier *)oid;

+ (id<JavaUtilEnumeration>)getNames;

- (instancetype)init;

@end

FOUNDATION_EXPORT BOOL OrgBouncycastleCryptoEcCustomNamedCurves_initialized;
J2OBJC_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves)

CF_EXTERN_C_BEGIN

FOUNDATION_EXPORT void OrgBouncycastleCryptoEcCustomNamedCurves_defineCurveWithNSString_withOrgBouncycastleAsn1X9X9ECParametersHolder_(NSString *name, OrgBouncycastleAsn1X9X9ECParametersHolder *holder);

FOUNDATION_EXPORT void OrgBouncycastleCryptoEcCustomNamedCurves_defineCurveWithOIDWithNSString_withOrgBouncycastleAsn1ASN1ObjectIdentifier_withOrgBouncycastleAsn1X9X9ECParametersHolder_(NSString *name, OrgBouncycastleAsn1ASN1ObjectIdentifier *oid, OrgBouncycastleAsn1X9X9ECParametersHolder *holder);

FOUNDATION_EXPORT void OrgBouncycastleCryptoEcCustomNamedCurves_defineCurveAliasWithNSString_withOrgBouncycastleAsn1ASN1ObjectIdentifier_(NSString *alias, OrgBouncycastleAsn1ASN1ObjectIdentifier *oid);

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParameters *OrgBouncycastleCryptoEcCustomNamedCurves_getByNameWithNSString_(NSString *name);

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParameters *OrgBouncycastleCryptoEcCustomNamedCurves_getByOIDWithOrgBouncycastleAsn1ASN1ObjectIdentifier_(OrgBouncycastleAsn1ASN1ObjectIdentifier *oid);

FOUNDATION_EXPORT OrgBouncycastleAsn1ASN1ObjectIdentifier *OrgBouncycastleCryptoEcCustomNamedCurves_getOIDWithNSString_(NSString *name);

FOUNDATION_EXPORT NSString *OrgBouncycastleCryptoEcCustomNamedCurves_getNameWithOrgBouncycastleAsn1ASN1ObjectIdentifier_(OrgBouncycastleAsn1ASN1ObjectIdentifier *oid);

FOUNDATION_EXPORT id<JavaUtilEnumeration> OrgBouncycastleCryptoEcCustomNamedCurves_getNames();

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_curve25519_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, curve25519_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, curve25519_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp192k1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp192k1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp192k1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp192r1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp192r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp192r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp224k1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp224k1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp224k1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp224r1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp224r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp224r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp256k1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp256k1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp256k1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp256r1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp256r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp256r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp384r1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp384r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp384r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT OrgBouncycastleAsn1X9X9ECParametersHolder *OrgBouncycastleCryptoEcCustomNamedCurves_secp521r1_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp521r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)
J2OBJC_STATIC_FIELD_SETTER(OrgBouncycastleCryptoEcCustomNamedCurves, secp521r1_, OrgBouncycastleAsn1X9X9ECParametersHolder *)

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleCryptoEcCustomNamedCurves_nameToCurve_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, nameToCurve_, JavaUtilHashtable *)

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleCryptoEcCustomNamedCurves_nameToOID_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, nameToOID_, JavaUtilHashtable *)

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleCryptoEcCustomNamedCurves_oidToCurve_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, oidToCurve_, JavaUtilHashtable *)

FOUNDATION_EXPORT JavaUtilHashtable *OrgBouncycastleCryptoEcCustomNamedCurves_oidToName_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleCryptoEcCustomNamedCurves, oidToName_, JavaUtilHashtable *)
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$1 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$1)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$1)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$2 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$2)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$2)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$3 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$3)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$3)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$4 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$4)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$4)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$5 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$5)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$5)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$6 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$6)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$6)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$7 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$7)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$7)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$8 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$8)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$8)

@interface OrgBouncycastleCryptoEcCustomNamedCurves_$9 : OrgBouncycastleAsn1X9X9ECParametersHolder {
}

- (OrgBouncycastleAsn1X9X9ECParameters *)createParameters;

- (instancetype)init;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleCryptoEcCustomNamedCurves_$9)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleCryptoEcCustomNamedCurves_$9)

#endif // _OrgBouncycastleCryptoEcCustomNamedCurves_H_