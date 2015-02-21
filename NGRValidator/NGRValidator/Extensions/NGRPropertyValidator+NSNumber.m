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

- (void)validateNumberWithName:(NSString *)name block:(NGRNumberValidationBlock)block {
    [self validateClass:[NSNumber class] withName:name validationBlock:^NGRError(NSNumber *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(float))min {
    return ^(float min) {
        [self validateNumberWithName:@"min" block:^NGRError(NSNumber *number) {
            return (number.floatValue < min) ? NGRErrorTooSmall : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(float))max {
    return ^(float max) {
        [self validateNumberWithName:@"max" block:^NGRError(NSNumber *number) {
            return (number.floatValue > max) ? NGRErrorTooBig : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(float, float))range {
    return ^(float min, float max) {
        [self validateNumberWithName:@"range" block:^NGRError(NSNumber *number) {
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
        [self validateNumberWithName:@"exact" block:^NGRError(NSNumber *number) {
            return ([number isEqualToNumber:@(exactFloat)]) ? NGRErrorNoone : NGRErrorNotExact;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())beFalse {
    return ^() {
        [self validateNumberWithName:@"false value" block:^NGRError(NSNumber *number) {
            return [number boolValue] ? NGRErrorNotFalse : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())beTrue {
    return ^() {
        [self validateNumberWithName:@"true value" block:^NGRError(NSNumber *number) {
            return [number boolValue] ? NGRErrorNoone : NGRErrorNotTrue;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgTooSmall {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorTooSmall];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgTooBig {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorTooBig];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExact {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotExact];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotTrue {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotTrue];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotFalse {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotFalse];
        return self;
    };
}

@end
