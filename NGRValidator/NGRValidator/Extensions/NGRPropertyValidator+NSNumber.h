//
//  NGRPropertyValidator+NSNumber.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSNumber)

#pragma mark - Rules

/**
 *  Validates lower limit of NSNumber (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^min)(float min);

/**
 *  Validates upper limit of NSNumber (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^max)(float max);

/**
 *  Validates minimum and maximum value of NSSNumber (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^range)(float min, float max);

/**
 *  Validates exact value of NSNumber.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^exact)(float exact);

/**
 *  Validates if NSNumber represents false status.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^falseValue)();

/**
 *  Validates if NSNumber represents true status.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^trueValue)();

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property value is too small.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^tooSmall)(NSString *message);

/**
 *  User-defined error message used when validated property value is too big.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^tooBig)(NSString *message);

/**
 *  User-defined error message used when validated property hasn't exact value.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notExact)(NSString *message);

/**
 *  User-defined error message used when validated property value isn't false.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notFalse)(NSString *message);

/**
 *  User-defined error message used when validated property value isn't true.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notTrue)(NSString *message);

@end
