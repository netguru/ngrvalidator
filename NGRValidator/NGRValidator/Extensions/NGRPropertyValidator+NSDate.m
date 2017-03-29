//
//  NGRPropertyValidator+NSDate.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSDate.h"
#import "NSDate+NGRValidator.h"

typedef NGRMsgKey *(^NGRDateValidationBlock)(NSDate *mainDate);

@implementation NGRPropertyValidator (NSDate)

#pragma mark - Rules

- (void)validateDateWithName:(NSString *)name block:(NGRDateValidationBlock)block {
    [self validateClass:[NSDate class] withName:name validationBlock:^NGRMsgKey *(NSDate *date) {
        return block(date);
    }];
}

- (NGRPropertyValidator *(^)(NSDate *))earlierThan {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"earlier than" block:^NGRMsgKey *(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isEarlierThan:toDate] ? nil : MSGNotEarlierThan;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *))earlierThanOrEqualTo {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"earlier than or equal to" block:^NGRMsgKey *(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isEarlierThanOrEqualTo:toDate] ? nil : MSGNotEarlierThanOrEqualTo;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *))laterThan {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"later than" block:^NGRMsgKey *(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isLaterThan:toDate] ? nil : MSGNotLaterThan;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *))laterThanOrEqualTo {
    return ^(NSDate *toDate) {
        [self validateDateWithName:@"later than or equal to" block:^NGRMsgKey *(NSDate *mainDate) {
            [self checkArgument:toDate];
            return [mainDate ngr_isLaterThanOrEqualTo:toDate] ? nil : MSGNotLaterThanOrEqualTo;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSDate *, NSDate *, BOOL))betweenDates {
    return ^(NSDate *fromDate, NSDate *toDate, BOOL inclusive) {
        [self validateDateWithName:@"between dates" block:^NGRMsgKey *(NSDate *mainDate) {
            [self checkArgument:fromDate];
            [self checkArgument:toDate];
            return [mainDate ngr_isBetweenFirstDate:fromDate lastDate:toDate inclusive:inclusive] ? nil : MSGNotBetweenDates;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSTimeInterval))earlierThanUnixTimestamp {
    return ^(NSTimeInterval timestamp) {
        NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
        [self validateDateWithName:@"earlier than unix timestamp" block:^NGRMsgKey *(NSDate *date) {
            [self checkArgument:date];
            return [date ngr_isEarlierThan:timestampDate] ? nil : MSGNotEarlierThan;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSTimeInterval))earlierThanOrEqualToUnixTimestamp {
    return ^(NSTimeInterval timestamp) {
        NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
        [self validateDateWithName:@"earlier than or equal to unix timestamp" block:^NGRMsgKey *(NSDate *date) {
            [self checkArgument:date];
            return [date ngr_isEarlierThanOrEqualTo:timestampDate] ? nil : MSGNotEarlierThanOrEqualTo;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSTimeInterval))laterThanUnixTimestamp {
    return ^(NSTimeInterval timestamp) {
        NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
        [self validateDateWithName:@"later than unix timestamp" block:^NGRMsgKey *(NSDate *date) {
            [self checkArgument:date];
            return [date ngr_isLaterThan:timestampDate] ? nil : MSGNotLaterThan;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSTimeInterval))laterThanOrEqualToUnixTimestamp {
    return ^(NSTimeInterval timestamp) {
        NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
        [self validateDateWithName:@"later than or equal to unix timestamp" block:^NGRMsgKey *(NSDate *date) {
            [self checkArgument:date];
            return [date ngr_isLaterThanOrEqualTo:timestampDate] ? nil : MSGNotLaterThanOrEqualTo;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *message))msgNotEarlierThan {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotEarlierThan];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *message))msgNotLaterThan {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotLaterThan];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *message))msgNotEarlierThanOrEqualTo {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotEarlierThanOrEqualTo];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *message))msgNotLaterThanOrEqualTo {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotLaterThanOrEqualTo];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotBetweenDates {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotBetweenDates];
        return self;
    };
}

#pragma mark - Private

- (void)checkArgument:(id)argument {
    if (!argument) {
        NSLog(@"[WARNING] A date which is %@ compared to, is nil", self.property);
    }
}

@end
