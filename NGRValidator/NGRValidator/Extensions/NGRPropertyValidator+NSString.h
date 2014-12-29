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
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^minLength)(NSUInteger min);

/**
 *  Validates maximum length of NSString (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^maxLength)(NSUInteger min);

/**
 *  Validates minimum and maximum length of NSString (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^lengthRange)(NSUInteger min, NSUInteger max);

/**
 *  Validates exact length of NSString (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^exactLength)(NSUInteger length);

/**
 *  Validates that the NSString match another string
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^match)(NSString *string);

/**
 *  Validates that the NSString contains only decimal signs.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^decimal)();

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property length is too short.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^msgTooShort)(NSString *message);

/**
 *  User-defined error message used when validated property length is too long.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^msgTooLong)(NSString *message);

/**
 *  User-defined error message used when validated property hasn't exact length.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^msgNotExactLength)(NSString *message);

/**
 *  User-defined error message used when validated property doesn't match another string.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^msgNotMatch)(NSString *message);

/**
 *  User-defined error message used when validated property is not decimal.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^msgNotDecimal)(NSString *message);

@end
