//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/math/ec/custom/sec/SecP192K1Field.java
//

#ifndef _OrgBouncycastleMathEcCustomSecSecP192K1Field_H_
#define _OrgBouncycastleMathEcCustomSecSecP192K1Field_H_

@class IOSIntArray;
@class JavaMathBigInteger;

#include "J2ObjC_header.h"

#define OrgBouncycastleMathEcCustomSecSecP192K1Field_P5 -1
#define OrgBouncycastleMathEcCustomSecSecP192K1Field_PExt11 -1
#define OrgBouncycastleMathEcCustomSecSecP192K1Field_PInv33 4553

@interface OrgBouncycastleMathEcCustomSecSecP192K1Field : NSObject {
}

+ (void)addWithIntArray:(IOSIntArray *)x
           withIntArray:(IOSIntArray *)y
           withIntArray:(IOSIntArray *)z;

+ (void)addExtWithIntArray:(IOSIntArray *)xx
              withIntArray:(IOSIntArray *)yy
              withIntArray:(IOSIntArray *)zz;

+ (void)addOneWithIntArray:(IOSIntArray *)x
              withIntArray:(IOSIntArray *)z;

+ (IOSIntArray *)fromBigIntegerWithJavaMathBigInteger:(JavaMathBigInteger *)x;

+ (void)halfWithIntArray:(IOSIntArray *)x
            withIntArray:(IOSIntArray *)z;

+ (void)multiplyWithIntArray:(IOSIntArray *)x
                withIntArray:(IOSIntArray *)y
                withIntArray:(IOSIntArray *)z;

+ (void)multiplyAddToExtWithIntArray:(IOSIntArray *)x
                        withIntArray:(IOSIntArray *)y
                        withIntArray:(IOSIntArray *)zz;

+ (void)negateWithIntArray:(IOSIntArray *)x
              withIntArray:(IOSIntArray *)z;

+ (void)reduceWithIntArray:(IOSIntArray *)xx
              withIntArray:(IOSIntArray *)z;

+ (void)reduce32WithInt:(jint)x
           withIntArray:(IOSIntArray *)z;

+ (void)squareWithIntArray:(IOSIntArray *)x
              withIntArray:(IOSIntArray *)z;

+ (void)squareNWithIntArray:(IOSIntArray *)x
                    withInt:(jint)n
               withIntArray:(IOSIntArray *)z;

+ (void)subtractWithIntArray:(IOSIntArray *)x
                withIntArray:(IOSIntArray *)y
                withIntArray:(IOSIntArray *)z;

+ (void)subtractExtWithIntArray:(IOSIntArray *)xx
                   withIntArray:(IOSIntArray *)yy
                   withIntArray:(IOSIntArray *)zz;

+ (void)twiceWithIntArray:(IOSIntArray *)x
             withIntArray:(IOSIntArray *)z;

- (instancetype)init;

@end

FOUNDATION_EXPORT BOOL OrgBouncycastleMathEcCustomSecSecP192K1Field_initialized;
J2OBJC_STATIC_INIT(OrgBouncycastleMathEcCustomSecSecP192K1Field)

CF_EXTERN_C_BEGIN

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_addWithIntArray_withIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *y, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_addExtWithIntArray_withIntArray_withIntArray_(IOSIntArray *xx, IOSIntArray *yy, IOSIntArray *zz);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_addOneWithIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *z);

FOUNDATION_EXPORT IOSIntArray *OrgBouncycastleMathEcCustomSecSecP192K1Field_fromBigIntegerWithJavaMathBigInteger_(JavaMathBigInteger *x);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_halfWithIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_multiplyWithIntArray_withIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *y, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_multiplyAddToExtWithIntArray_withIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *y, IOSIntArray *zz);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_negateWithIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_reduceWithIntArray_withIntArray_(IOSIntArray *xx, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_reduce32WithInt_withIntArray_(jint x, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_squareWithIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_squareNWithIntArray_withInt_withIntArray_(IOSIntArray *x, jint n, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_subtractWithIntArray_withIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *y, IOSIntArray *z);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_subtractExtWithIntArray_withIntArray_withIntArray_(IOSIntArray *xx, IOSIntArray *yy, IOSIntArray *zz);

FOUNDATION_EXPORT void OrgBouncycastleMathEcCustomSecSecP192K1Field_twiceWithIntArray_withIntArray_(IOSIntArray *x, IOSIntArray *z);

FOUNDATION_EXPORT IOSIntArray *OrgBouncycastleMathEcCustomSecSecP192K1Field_P_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleMathEcCustomSecSecP192K1Field, P_, IOSIntArray *)

FOUNDATION_EXPORT IOSIntArray *OrgBouncycastleMathEcCustomSecSecP192K1Field_PExt_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleMathEcCustomSecSecP192K1Field, PExt_, IOSIntArray *)

FOUNDATION_EXPORT IOSIntArray *OrgBouncycastleMathEcCustomSecSecP192K1Field_PExtInv_;
J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleMathEcCustomSecSecP192K1Field, PExtInv_, IOSIntArray *)

J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleMathEcCustomSecSecP192K1Field, P5, jint)

J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleMathEcCustomSecSecP192K1Field, PExt11, jint)

J2OBJC_STATIC_FIELD_GETTER(OrgBouncycastleMathEcCustomSecSecP192K1Field, PInv33, jint)
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleMathEcCustomSecSecP192K1Field)

#endif // _OrgBouncycastleMathEcCustomSecSecP192K1Field_H_