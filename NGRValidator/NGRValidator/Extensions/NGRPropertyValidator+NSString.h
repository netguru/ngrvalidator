//
//  NGRPropertyValidator+NSString.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSString)

#pragma mark - Rules

/**
 *  Validates minimum length of NSString (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^minLength)(NSUInteger min);

/**
 *  Validates maximum length of NSString (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^maxLength)(NSUInteger min);

/**
 *  Validates minimum and maximum length of NSString (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^lengthRange)(NSUInteger min, NSUInteger max);

/**
 *  Validates exact length of NSString (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^exactLength)(NSUInteger length);

/**
 *  Validates that the NSString match another string
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^match)(NSString *string);

/**
 *  Validates that the NSString is different than another string
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^differ)(NSString *string);

/**
 *  Validates that the NSString contains only decimal signs.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^decimal)();

#pragma mark - Messaging

/**
 *  User-defined error message used when validated string length is too short.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgTooShort)(NSString *message);

/**
 *  User-defined error message used when validated string length is too long.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgTooLong)(NSString *message);

/**
 *  User-defined error message used when validated string hasn't exact length.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExactLength)(NSString *message);

/**
 *  User-defined error message used when validated string doesn't match another string.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotMatch)(NSString *message);

/**
 *  User-defined error message used when validated string doesn't differ from another string.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotDiffer)(NSString *message);

/**
 *  User-defined error message used when validated string is not decimal.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotDecimal)(NSString *message);

@end
