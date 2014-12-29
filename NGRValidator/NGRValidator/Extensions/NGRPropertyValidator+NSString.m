//
//  NGRPropertyValidator+NSString.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSString.h"
#import "NSString+NGRValidator.h"

typedef NGRError (^NGRStringValidationBlock)(NSString *string);

@implementation NGRPropertyValidator (NSString)

#pragma mark - Rules

- (void)validateStringWithBlock:(NGRStringValidationBlock)validationBlock {
    [self validateClass:[NSString class] withBlock:^NGRError(NSString *value) {
        return validationBlock(value);
    }];
}

- (NGRPropertyValidator *(^)(NSUInteger min))minLength {
    return ^(NSUInteger min) {
        [self validateStringWithBlock:^NGRError(NSString *string) {
            return (string.length < min) ? NGRErrorTooShort : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger))maxLength {
    return ^(NSUInteger max) {
        [self validateStringWithBlock:^NGRError(NSString *string) {
            return (string.length > max) ? NGRErrorTooLong : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger, NSUInteger))lengthRange {
    return ^(NSUInteger min, NSUInteger max) {
        [self validateStringWithBlock:^NGRError(NSString *string) {
            if (string.length > MAX(min, max)) {
                return NGRErrorTooLong;
            } else if (string.length < MIN(min, max)) {
                return NGRErrorTooShort;
            }
            return NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger))exactLength {
    return ^(NSUInteger length) {
        [self validateStringWithBlock:^NGRError(NSString *string) {
            return (string.length != length) ? NGRErrorNotExactLength : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))match {
    return ^(NSString *stringToMatch) {
        [self validateStringWithBlock:^NGRError(NSString *string) {
            return [string isEqualToString:stringToMatch] ? NGRErrorNoone : NGRErrorNotMatch;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())decimal {
    return ^() {
        [self validateStringWithBlock:^NGRError(NSString *string) {
            return [string ngr_isDecimal] ? NGRErrorNoone : NGRErrorNotDecimal;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgTooShort {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorTooShort];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgTooLong {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorTooLong];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExactLength {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorNotExactLength];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotMatch {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorNotMatch];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotDecimal {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorNotDecimal];
        return self;
    };
}

@end
