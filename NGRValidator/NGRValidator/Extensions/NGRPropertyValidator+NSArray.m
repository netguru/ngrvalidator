//
//  NGRPropertyValidator+NSArray.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21/07/15.
//
//

#import "NGRPropertyValidator+NSArray.h"

typedef NGRMsgKey *(^NGRArrayValidationBlock)(NSArray *array);

@implementation NGRPropertyValidator (NSArray)

#pragma mark - Rules

- (void)validateArrayWithName:(NSString *)name block:(NGRArrayValidationBlock)block {
    [self validateClass:[NSArray class] withName:name validationBlock:^NGRMsgKey *(NSArray *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NSObject *))includes {
    return ^(NSObject *object) {
        [self validateArrayWithName:@"include" block:^NGRMsgKey *(NSArray *array) {
            return [array containsObject:object] ? nil : MSGNotIncludes;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSObject *))excludes {
    return ^(NSObject *object) {
        [self validateArrayWithName:@"exclude" block:^NGRMsgKey *(NSArray *array) {
            return [array containsObject:object] ? MSGNotExcludes : nil;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgNotIncludes {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotIncludes];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExcludes {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotExcludes];
        return self;
    };
}

@end
