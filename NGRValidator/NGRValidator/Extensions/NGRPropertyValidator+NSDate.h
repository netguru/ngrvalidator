//
//  NGRPropertyValidator+NSDate.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSDate)

#pragma mark - Rules

/**
 *  Validates if NSDate property is earlier than given date (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^earlierThan)(NSDate *date);

/**
 *  Validates if NSDate property is earlier than or equal to given date (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^earlierThanOrEqualTo)(NSDate *date);

/**
 *  Validates if NSDate property is later than given date (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^laterThan)(NSDate *date);

/**
 *  Validates if NSDate property is later than or equal to given date (inclusive).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^laterThanOrEqualTo)(NSDate *date);

/**
 *  Validates if NSDate property is between given dates. Inclusive parameter specify inclusiveness of comparison.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^betweenDates)(NSDate *fromDate, NSDate *toDate, BOOL inclusive);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property is not later than compared one.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotLaterThan)(NSString *message);

/**
 *  User-defined error message used when validated property is not earlier than compared one.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotEarlierThan)(NSString *message);

/**
 *  User-defined error message used when validated property is not later than or equal to compared one.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotLaterThanOrEqualTo)(NSString *message);

/**
 *  User-defined error message used when validated property is not earlier than or equal to compared one.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotEarlierThanOrEqualTo)(NSString *message);

/**
 *  User-defined error message used when validated property is not between dates.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotBetweenDates)(NSString *message);

@end
