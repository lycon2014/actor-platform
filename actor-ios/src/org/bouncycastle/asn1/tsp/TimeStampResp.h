//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/asn1/tsp/TimeStampResp.java
//

#ifndef _OrgBouncycastleAsn1TspTimeStampResp_H_
#define _OrgBouncycastleAsn1TspTimeStampResp_H_

@class OrgBouncycastleAsn1ASN1Primitive;
@class OrgBouncycastleAsn1ASN1Sequence;
@class OrgBouncycastleAsn1CmpPKIStatusInfo;
@class OrgBouncycastleAsn1CmsContentInfo;

#include "J2ObjC_header.h"
#include "org/bouncycastle/asn1/ASN1Object.h"

@interface OrgBouncycastleAsn1TspTimeStampResp : OrgBouncycastleAsn1ASN1Object {
 @public
  OrgBouncycastleAsn1CmpPKIStatusInfo *pkiStatusInfo_;
  OrgBouncycastleAsn1CmsContentInfo *timeStampToken_;
}

+ (OrgBouncycastleAsn1TspTimeStampResp *)getInstanceWithId:(id)o;

- (instancetype)initWithOrgBouncycastleAsn1CmpPKIStatusInfo:(OrgBouncycastleAsn1CmpPKIStatusInfo *)pkiStatusInfo
                      withOrgBouncycastleAsn1CmsContentInfo:(OrgBouncycastleAsn1CmsContentInfo *)timeStampToken;

- (OrgBouncycastleAsn1CmpPKIStatusInfo *)getStatus;

- (OrgBouncycastleAsn1CmsContentInfo *)getTimeStampToken;

- (OrgBouncycastleAsn1ASN1Primitive *)toASN1Primitive;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleAsn1TspTimeStampResp)

J2OBJC_FIELD_SETTER(OrgBouncycastleAsn1TspTimeStampResp, pkiStatusInfo_, OrgBouncycastleAsn1CmpPKIStatusInfo *)
J2OBJC_FIELD_SETTER(OrgBouncycastleAsn1TspTimeStampResp, timeStampToken_, OrgBouncycastleAsn1CmsContentInfo *)

CF_EXTERN_C_BEGIN

FOUNDATION_EXPORT OrgBouncycastleAsn1TspTimeStampResp *OrgBouncycastleAsn1TspTimeStampResp_getInstanceWithId_(id o);
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1TspTimeStampResp)

#endif // _OrgBouncycastleAsn1TspTimeStampResp_H_