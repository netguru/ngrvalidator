//
//  NGRPropertyValidator+NSNumber.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC && !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>
#endif

@interface NGRPropertyValidator (NSNumber)

#pragma mark - Rules

/**
 *  Validates lower limit of NSNumber (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^min)(CGFloat min);

/**
 *  Validates upper limit of NSNumber (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^max)(CGFloat max);

/**
 *  Validates minimum and maximum value of NSSNumber (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^range)(CGFloat min, CGFloat max);

/**
 *  Validates exact value of NSNumber.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^exact)(CGFloat exact);

/**
 *  Validates if NSNumber represents false status.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^beFalse)();

/**
 *  Validates if NSNumber represents true status.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^beTrue)();

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property value is too small.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgTooSmall)(NSString *message);

/**
 *  User-defined error message used when validated property value is too big.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgTooBig)(NSString *message);

/**
 *  User-defined error message used when validated property hasn't exact value.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExact)(NSString *message);

/**
 *  User-defined error message used when validated property value isn't false.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotFalse)(NSString *message);

/**
 *  User-defined error message used when validated property value isn't true.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotTrue)(NSString *message);

@end
