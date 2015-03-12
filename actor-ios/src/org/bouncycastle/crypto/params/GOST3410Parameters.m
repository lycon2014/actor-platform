//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/crypto/params/GOST3410Parameters.java
//

#include "J2ObjC_source.h"
#include "java/math/BigInteger.h"
#include "org/bouncycastle/crypto/params/GOST3410Parameters.h"
#include "org/bouncycastle/crypto/params/GOST3410ValidationParameters.h"

@interface OrgBouncycastleCryptoParamsGOST3410Parameters () {
 @public
  JavaMathBigInteger *p_;
  JavaMathBigInteger *q_;
  JavaMathBigInteger *a_;
  OrgBouncycastleCryptoParamsGOST3410ValidationParameters *validation_;
}
@end

J2OBJC_FIELD_SETTER(OrgBouncycastleCryptoParamsGOST3410Parameters, p_, JavaMathBigInteger *)
J2OBJC_FIELD_SETTER(OrgBouncycastleCryptoParamsGOST3410Parameters, q_, JavaMathBigInteger *)
J2OBJC_FIELD_SETTER(OrgBouncycastleCryptoParamsGOST3410Parameters, a_, JavaMathBigInteger *)
J2OBJC_FIELD_SETTER(OrgBouncycastleCryptoParamsGOST3410Parameters, validation_, OrgBouncycastleCryptoParamsGOST3410ValidationParameters *)

@implementation OrgBouncycastleCryptoParamsGOST3410Parameters

- (instancetype)initWithJavaMathBigInteger:(JavaMathBigInteger *)p
                    withJavaMathBigInteger:(JavaMathBigInteger *)q
                    withJavaMathBigInteger:(JavaMathBigInteger *)a {
  if (self = [super init]) {
    self->p_ = p;
    self->q_ = q;
    self->a_ = a;
  }
  return self;
}

- (instancetype)initWithJavaMathBigInteger:(JavaMathBigInteger *)p
                    withJavaMathBigInteger:(JavaMathBigInteger *)q
                    withJavaMathBigInteger:(JavaMathBigInteger *)a
withOrgBouncycastleCryptoParamsGOST3410ValidationParameters:(OrgBouncycastleCryptoParamsGOST3410ValidationParameters *)params {
  if (self = [super init]) {
    self->a_ = a;
    self->p_ = p;
    self->q_ = q;
    self->validation_ = params;
  }
  return self;
}

- (JavaMathBigInteger *)getP {
  return p_;
}

- (JavaMathBigInteger *)getQ {
  return q_;
}

- (JavaMathBigInteger *)getA {
  return a_;
}

- (OrgBouncycastleCryptoParamsGOST3410ValidationParameters *)getValidationParameters {
  return validation_;
}

- (NSUInteger)hash {
  return ((jint) [((JavaMathBigInteger *) nil_chk(p_)) hash]) ^ ((jint) [((JavaMathBigInteger *) nil_chk(q_)) hash]) ^ ((jint) [((JavaMathBigInteger *) nil_chk(a_)) hash]);
}

- (jboolean)isEqual:(id)obj {
  if (!([obj isKindOfClass:[OrgBouncycastleCryptoParamsGOST3410Parameters class]])) {
    return NO;
  }
  OrgBouncycastleCryptoParamsGOST3410Parameters *pm = (OrgBouncycastleCryptoParamsGOST3410Parameters *) check_class_cast(obj, [OrgBouncycastleCryptoParamsGOST3410Parameters class]);
  return ([((JavaMathBigInteger *) nil_chk([((OrgBouncycastleCryptoParamsGOST3410Parameters *) nil_chk(pm)) getP])) isEqual:p_] && [((JavaMathBigInteger *) nil_chk([pm getQ])) isEqual:q_] && [((JavaMathBigInteger *) nil_chk([pm getA])) isEqual:a_]);
}

- (void)copyAllFieldsTo:(OrgBouncycastleCryptoParamsGOST3410Parameters *)other {
  [super copyAllFieldsTo:other];
  other->p_ = p_;
  other->q_ = q_;
  other->a_ = a_;
  other->validation_ = validation_;
}

@end

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(OrgBouncycastleCryptoParamsGOST3410Parameters)