//
//  NGRPropertyValidator+NSNumber.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSNumber.h"

typedef NGRError (^NGRNumberValidationBlock)(NSNumber *number);

@implementation NGRPropertyValidator (NSNumber)

#pragma mark - Rules

- (void)validateNumberWithBlock:(NGRNumberValidationBlock)validationBlock {
    [self validateClass:[NSNumber class] withBlock:^NGRError(NSNumber *value) {
        return validationBlock(value);
    }];
}

- (NGRPropertyValidator *(^)(float))min {
    return ^(float min) {
        [self validateNumberWithBlock:^NGRError(NSNumber *number) {
            return (number.floatValue < min) ? NGRErrorTooSmall : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(float))max {
    return ^(float max) {
        [self validateNumberWithBlock:^NGRError(NSNumber *number) {
            return (number.floatValue > max) ? NGRErrorTooBig : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(float, float))range {
    return ^(float min, float max) {
        [self validateNumberWithBlock:^NGRError(NSNumber *number) {
            if (number.floatValue > MAX(min, max)) {
                return NGRErrorTooBig;
            } else if (number.floatValue < MIN(min, max)) {
                return NGRErrorTooSmall;
            }
            return NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(float))exact {
    return ^(float exactFloat) {
        [self validateNumberWithBlock:^NGRError(NSNumber *number) {
            return ([number isEqualToNumber:@(exactFloat)]) ? NGRErrorNoone : NGRErrorNotExact;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())falseValue {
    return ^() {
        [self validateNumberWithBlock:^NGRError(NSNumber *number) {
            return ([number isEqualToNumber:@NO]) ? NGRErrorNoone : NGRErrorNotFalse;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())trueValue {
    return ^() {
        [self validateNumberWithBlock:^NGRError(NSNumber *number) {
            return ([number isEqualToNumber:@YES]) ? NGRErrorNoone : NGRErrorNotTrue;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgTooSmall {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorTooSmall];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgTooBig {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorTooBig];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExact {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorNotExact];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotTrue {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorNotTrue];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotFalse {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorNotFalse];
        return self;
    };
}

@end
