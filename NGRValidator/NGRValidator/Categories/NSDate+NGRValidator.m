//
//  NSDate+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSDate+NGRValidator.h"

@implementation NSDate (NGRValidator)

#pragma mark - Public

- (BOOL)ngr_isBetweenFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate inclusive:(BOOL)inclusive {
    if (inclusive) {
        return !([self compare:firstDate] == NSOrderedAscending) && !([self compare:lastDate] == NSOrderedDescending);
    }
    return [self compare:firstDate] == NSOrderedDescending && [self compare:lastDate]  == NSOrderedAscending;
}

- (BOOL)ngr_isLaterThanOrEqualTo:(NSDate *)date {
    return !([self compare:date] == NSOrderedAscending);
}

- (BOOL)ngr_isEarlierThanOrEqualTo:(NSDate *)date {
    return !([self compare:date] == NSOrderedDescending);
}

- (BOOL)ngr_isLaterThan:(NSDate *)date {
    return ([self compare:date] == NSOrderedDescending);
    
}
- (BOOL)ngr_isEarlierThan:(NSDate *)date {
    return ([self compare:date] == NSOrderedAscending);
}

@end
