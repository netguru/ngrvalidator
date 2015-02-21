//
//  NGRPropertyValidator+NSDate.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSDate.h"
#import "NSDate+NGRValidator.h"

typedef NGRError (^NGRDateValidationBlock)(NSDate *mainDate);

@implementation NGRPropertyValidator (NSDate)

#pragma mark - Rules

- (void)validateDateWithName:(NSString *)name block:(NGRDateValidationBlock)block {
    [self validateClass:[NSDate class] withName:name validationBlock:^NGRError(NSDate *date) {
        return block(date);
    }];
}

- (NGRPropertyValidator *(^)(NSDate *))earlierThan {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"earlier than" block:^NGRError(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isEarlierThan:toDate] ? NGRErrorNoone : NGRErrorNotEarlierThan;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *))earlierThanOrEqualTo {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"earlier than or equal to" block:^NGRError(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isEarlierThanOrEqualTo:toDate] ? NGRErrorNoone : NGRErrorNotEarlierThanOrEqualTo;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *))laterThan {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"later than" block:^NGRError(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isLaterThan:toDate] ? NGRErrorNoone : NGRErrorNotLaterThan;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *))laterThanOrEqualTo {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"later than or equal to" block:^NGRError(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isLaterThanOrEqualTo:toDate] ? NGRErrorNoone : NGRErrorNotLaterThanOrEqualTo;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *, NSDate *, BOOL))betweenDates {
    return ^(NSDate *fromDate, NSDate *toDate, BOOL inclusive) {
        [self validateDateWithName:@"between dates" block:^NGRError(NSDate *mainDate) {
            [self checkArgument:fromDate];
            [self checkArgument:toDate];
            return [mainDate ngr_isBetweenFirstDate:fromDate lastDate:toDate inclusive:inclusive] ? NGRErrorNoone : NGRErrorNotBetweenDates;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *message))msgNotEarlierThan {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotEarlierThan];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *message))msgNotLaterThan {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotLaterThan];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *message))msgNotEarlierThanOrEqualTo {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotEarlierThanOrEqualTo];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *message))msgNotLaterThanOrEqualTo {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotLaterThanOrEqualTo];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotBetweenDates {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotBetweenDates];
        return self;
    };
}

#pragma mark - Private Methods
- (void)checkArgument:(id)argument {
    if (!argument) {
        NSLog(@"[WARNING] A date which is %@ compared to, is nil", self.property);
    }
}

@end
