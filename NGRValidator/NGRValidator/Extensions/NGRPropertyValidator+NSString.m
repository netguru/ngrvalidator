//
//  NGRPropertyValidator+NSString.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSString.h"
#import "NSString+NGRValidator.h"

typedef NGRMsgKey *(^NGRStringValidationBlock)(NSString *string);

@implementation NGRPropertyValidator (NSString)

#pragma mark - Rules

- (void)validateStringWithName:(NSString *)name block:(NGRStringValidationBlock)block {
    [self validateClass:[NSString class] withName:name validationBlock:^NGRMsgKey *(NSString *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NSUInteger min))minLength {
    return ^(NSUInteger min) {
        [self validateStringWithName:@"minimum length" block:^NGRMsgKey *(NSString *string) {
            return (string.length < min) ? MSGTooShort : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger))maxLength {
    return ^(NSUInteger max) {
        [self validateStringWithName:@"maximum length" block:^NGRMsgKey *(NSString *string) {
            return (string.length > max) ? MSGTooLong : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger, NSUInteger))lengthRange {
    return ^(NSUInteger min, NSUInteger max) {
        [self validateStringWithName:@"length range" block:^NGRMsgKey *(NSString *string) {
            if (string.length > MAX(min, max)) {
                return MSGTooLong;
            } else if (string.length < MIN(min, max)) {
                return MSGTooShort;
            }
            return nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger))exactLength {
    return ^(NSUInteger length) {
        [self validateStringWithName:@"exact length" block:^NGRMsgKey *(NSString *string) {
            return (string.length != length) ? MSGNotExactLength : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))match {
    return ^(NSString *stringToMatch) {
        [self validateStringWithName:@"match" block:^NGRMsgKey *(NSString *string) {
            return [string isEqualToString:stringToMatch] ? nil : MSGNotMatch;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))differ {
    return ^(NSString *stringToMatch) {
        [self validateStringWithName:@"differ" block:^NGRMsgKey *(NSString *string) {
            return ![string isEqualToString:stringToMatch] ? nil : MSGNotDiffer;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())decimal {
    return ^() {
        [self validateStringWithName:@"decimal" block:^NGRMsgKey *(NSString *string) {
            return [string ngr_isDecimal] ? nil : MSGNotDecimal;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgTooShort {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGTooShort];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgTooLong {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGTooLong];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExactLength {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotExactLength];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotMatch {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotMatch];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotDiffer {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotDiffer];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotDecimal {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotDecimal];
        return self;
    };
}

@end
