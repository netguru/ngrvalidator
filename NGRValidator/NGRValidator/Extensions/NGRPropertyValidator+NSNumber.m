//
//  NGRPropertyValidator+NSNumber.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSNumber.h"

typedef NGRMsgKey *(^NGRNumberValidationBlock)(NSNumber *number);

@implementation NGRPropertyValidator (NSNumber)

#pragma mark - Rules

- (void)validateNumberWithName:(NSString *)name block:(NGRNumberValidationBlock)block {
    [self validateClass:[NSNumber class] withName:name validationBlock:^NGRMsgKey *(NSNumber *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(CGFloat))min {
    return ^(CGFloat min) {
        [self validateNumberWithName:@"min" block:^NGRMsgKey *(NSNumber *number) {
            return (number.floatValue < min) ? MSGTooSmall : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))max {
    return ^(CGFloat max) {
        [self validateNumberWithName:@"max" block:^NGRMsgKey *(NSNumber *number) {
            return (number.floatValue > max) ? MSGTooBig : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat, CGFloat))range {
    return ^(CGFloat min, CGFloat max) {
        [self validateNumberWithName:@"range" block:^NGRMsgKey *(NSNumber *number) {
            if (number.floatValue > MAX(min, max)) {
                return MSGTooBig;
            } else if (number.floatValue < MIN(min, max)) {
                return MSGTooSmall;
            }
            return nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(CGFloat))exact {
    return ^(CGFloat exactFloat) {
        [self validateNumberWithName:@"exact" block:^NGRMsgKey *(NSNumber *number) {
            return ([number isEqualToNumber:@(exactFloat)]) ? nil : MSGNotExact;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())beFalse {
    return ^() {
        [self validateNumberWithName:@"false value" block:^NGRMsgKey *(NSNumber *number) {
            return [number boolValue] ? MSGNotFalse : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())beTrue {
    return ^() {
        [self validateNumberWithName:@"true value" block:^NGRMsgKey *(NSNumber *number) {
            return [number boolValue] ? nil : MSGNotTrue;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgTooSmall {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGTooSmall];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgTooBig {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGTooBig];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExact {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotExact];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotTrue {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotTrue];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotFalse {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotFalse];
        return self;
    };
}

@end
