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

- (void)validateStringWithName:(NSString *)name block:(NGRStringValidationBlock)block {
    [self validateClass:[NSString class] withName:name validationBlock:^NGRError(NSString *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NSUInteger min))minLength {
    return ^(NSUInteger min) {
        [self validateStringWithName:@"minimum length" block:^NGRError(NSString *string) {
            return (string.length < min) ? NGRErrorTooShort : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger))maxLength {
    return ^(NSUInteger max) {
        [self validateStringWithName:@"maximum length" block:^NGRError(NSString *string) {
            return (string.length > max) ? NGRErrorTooLong : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger, NSUInteger))lengthRange {
    return ^(NSUInteger min, NSUInteger max) {
        [self validateStringWithName:@"length range" block:^NGRError(NSString *string) {
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
        [self validateStringWithName:@"exact length" block:^NGRError(NSString *string) {
            return (string.length != length) ? NGRErrorNotExactLength : NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))match {
    return ^(NSString *stringToMatch) {
        [self validateStringWithName:@"match" block:^NGRError(NSString *string) {
            return [string isEqualToString:stringToMatch] ? NGRErrorNoone : NGRErrorNotMatch;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))differ {
    return ^(NSString *stringToMatch) {
        [self validateStringWithName:@"differ" block:^NGRError(NSString *string) {
            return ![string isEqualToString:stringToMatch] ? NGRErrorNoone : NGRErrorNotDiffer;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())decimal {
    return ^() {
        [self validateStringWithName:@"decimal" block:^NGRError(NSString *string) {
            return [string ngr_isDecimal] ? NGRErrorNoone : NGRErrorNotDecimal;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgTooShort {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorTooShort];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgTooLong {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorTooLong];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExactLength {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotExactLength];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotMatch {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotMatch];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotDiffer {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotDiffer];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotDecimal {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorNotDecimal];
        return self;
    };
}

@end
