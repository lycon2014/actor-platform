//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/asn1/DERGeneralizedTime.java
//

#ifndef _OrgBouncycastleAsn1DERGeneralizedTime_H_
#define _OrgBouncycastleAsn1DERGeneralizedTime_H_

@class IOSByteArray;
@class JavaUtilDate;

#include "J2ObjC_header.h"
#include "org/bouncycastle/asn1/ASN1GeneralizedTime.h"

@interface OrgBouncycastleAsn1DERGeneralizedTime : OrgBouncycastleAsn1ASN1GeneralizedTime {
}

- (instancetype)initWithByteArray:(IOSByteArray *)bytes;

- (instancetype)initWithJavaUtilDate:(JavaUtilDate *)time;

- (instancetype)initWithNSString:(NSString *)time;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleAsn1DERGeneralizedTime)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1DERGeneralizedTime)

#endif // _OrgBouncycastleAsn1DERGeneralizedTime_H_