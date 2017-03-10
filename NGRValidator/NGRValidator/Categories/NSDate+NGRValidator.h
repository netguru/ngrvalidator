//
//  NSDate+NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (NGRValidator)

NS_ASSUME_NONNULL_BEGIN

- (BOOL)ngr_isBetweenFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate inclusive:(BOOL)inclusive;

- (BOOL)ngr_isLaterThanOrEqualTo:(NSDate *)date;

- (BOOL)ngr_isEarlierThanOrEqualTo:(NSDate *)date;

- (BOOL)ngr_isLaterThan:(NSDate *)date;

- (BOOL)ngr_isEarlierThan:(NSDate *)date;

NS_ASSUME_NONNULL_END

@end
