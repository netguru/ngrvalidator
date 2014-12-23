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
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^earlierThan)(NSDate *date);

/**
 *  Validates if NSDate property is earlier than or equal to given date (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^earlierThanOrEqualTo)(NSDate *date);

/**
 *  Validates if NSDate property is later than given date (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^laterThan)(NSDate *date);

/**
 *  Validates if NSDate property is later than or equal to given date (inclusive).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^laterThanOrEqualTo)(NSDate *date);

/**
 *  Validates if NSDate property is between given dates. Inclusive parameter specify inclusiveness of comparison.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^betweenDates)(NSDate *fromDate, NSDate *toDate, BOOL inclusive);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property is not later than compared one.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notLaterThan)(NSString *message);

/**
 *  User-defined error message used when validated property is not earlier than compared one.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notEarlierThan)(NSString *message);

/**
 *  User-defined error message used when validated property is not later than or equal to compared one.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notLaterThanOrEqualTo)(NSString *message);

/**
 *  User-defined error message used when validated property is not earlier than or equal to compared one.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notEarlierThanOrEqualTo)(NSString *message);

/**
 *  User-defined error message used when validated property is not between dates.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^notBetween)(NSString *message);

@end
