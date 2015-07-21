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

- (NGRPropertyValidator *(^)(NSObject *))include {
    return ^(NSObject *object) {
        [self validateArrayWithName:@"include" block:^NGRMsgKey *(NSArray *array) {
            return [array containsObject:object] ? nil : MSGNotInclude;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSObject *))exclude {
    return ^(NSObject *object) {
        [self validateArrayWithName:@"exclude" block:^NGRMsgKey *(NSArray *array) {
            return [array containsObject:object] ? MSGNotExclude : nil;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgNotInclude {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotInclude];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExclude {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotExclude];
        return self;
    };
}

@end
