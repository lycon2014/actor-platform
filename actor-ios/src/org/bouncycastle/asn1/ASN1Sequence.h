//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/ex3ndr/Develop/actor-model/actor-ios/build/java/org/bouncycastle/asn1/ASN1Sequence.java
//

#ifndef _OrgBouncycastleAsn1ASN1Sequence_H_
#define _OrgBouncycastleAsn1ASN1Sequence_H_

@class IOSObjectArray;
@class JavaUtilVector;
@class OrgBouncycastleAsn1ASN1EncodableVector;
@class OrgBouncycastleAsn1ASN1OutputStream;
@class OrgBouncycastleAsn1ASN1TaggedObject;
@protocol JavaUtilEnumeration;
@protocol OrgBouncycastleAsn1ASN1Encodable;

#include "J2ObjC_header.h"
#include "org/bouncycastle/asn1/ASN1Primitive.h"
#include "org/bouncycastle/asn1/ASN1SequenceParser.h"

@interface OrgBouncycastleAsn1ASN1Sequence : OrgBouncycastleAsn1ASN1Primitive {
 @public
  JavaUtilVector *seq_;
}

+ (OrgBouncycastleAsn1ASN1Sequence *)getInstanceWithId:(id)obj;

+ (OrgBouncycastleAsn1ASN1Sequence *)getInstanceWithOrgBouncycastleAsn1ASN1TaggedObject:(OrgBouncycastleAsn1ASN1TaggedObject *)obj
                                                                            withBoolean:(jboolean)explicit_;

- (instancetype)init;

- (instancetype)initWithOrgBouncycastleAsn1ASN1Encodable:(id<OrgBouncycastleAsn1ASN1Encodable>)obj;

- (instancetype)initWithOrgBouncycastleAsn1ASN1EncodableVector:(OrgBouncycastleAsn1ASN1EncodableVector *)v;

- (instancetype)initWithOrgBouncycastleAsn1ASN1EncodableArray:(IOSObjectArray *)array;

- (IOSObjectArray *)toArray;

- (id<JavaUtilEnumeration>)getObjects;

- (id<OrgBouncycastleAsn1ASN1SequenceParser>)parser;

- (id<OrgBouncycastleAsn1ASN1Encodable>)getObjectAtWithInt:(jint)index;

- (jint)size;

- (NSUInteger)hash;

- (jboolean)asn1EqualsWithOrgBouncycastleAsn1ASN1Primitive:(OrgBouncycastleAsn1ASN1Primitive *)o;

- (OrgBouncycastleAsn1ASN1Primitive *)toDERObject;

- (OrgBouncycastleAsn1ASN1Primitive *)toDLObject;

- (jboolean)isConstructed;

- (void)encodeWithOrgBouncycastleAsn1ASN1OutputStream:(OrgBouncycastleAsn1ASN1OutputStream *)outArg;

- (NSString *)description;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleAsn1ASN1Sequence)

J2OBJC_FIELD_SETTER(OrgBouncycastleAsn1ASN1Sequence, seq_, JavaUtilVector *)

CF_EXTERN_C_BEGIN

FOUNDATION_EXPORT OrgBouncycastleAsn1ASN1Sequence *OrgBouncycastleAsn1ASN1Sequence_getInstanceWithId_(id obj);

FOUNDATION_EXPORT OrgBouncycastleAsn1ASN1Sequence *OrgBouncycastleAsn1ASN1Sequence_getInstanceWithOrgBouncycastleAsn1ASN1TaggedObject_withBoolean_(OrgBouncycastleAsn1ASN1TaggedObject *obj, jboolean explicit_);
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1ASN1Sequence)

@interface OrgBouncycastleAsn1ASN1Sequence_$1 : NSObject < OrgBouncycastleAsn1ASN1SequenceParser > {
}

- (id<OrgBouncycastleAsn1ASN1Encodable>)readObject;

- (OrgBouncycastleAsn1ASN1Primitive *)getLoadedObject;

- (OrgBouncycastleAsn1ASN1Primitive *)toASN1Primitive;

- (instancetype)initWithOrgBouncycastleAsn1ASN1Sequence:(OrgBouncycastleAsn1ASN1Sequence *)outer$
                    withOrgBouncycastleAsn1ASN1Sequence:(OrgBouncycastleAsn1ASN1Sequence *)capture$0;

@end

J2OBJC_EMPTY_STATIC_INIT(OrgBouncycastleAsn1ASN1Sequence_$1)

CF_EXTERN_C_BEGIN
CF_EXTERN_C_END

J2OBJC_TYPE_LITERAL_HEADER(OrgBouncycastleAsn1ASN1Sequence_$1)

#endif // _OrgBouncycastleAsn1ASN1Sequence_H_