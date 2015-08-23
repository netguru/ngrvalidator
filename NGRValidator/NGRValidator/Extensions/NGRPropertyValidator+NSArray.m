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
            return ([array containsObject:object] && array.count != 0) ? nil : MSGNotIncludes;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSObject *))excludes {
    return ^(NSObject *object) {
        [self validateArrayWithName:@"exclude" block:^NGRMsgKey *(NSArray *array) {
            return ([array containsObject:object] || array.count == 0) ? MSGNotExcludes : nil;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSArray *))includedIn {
    return ^(NSArray *array) {
        [self validateClass:[NSObject class] withName:@"included in" validationBlock:^NGRMsgKey *(NSObject *value) {
            return [array containsObject:value] ? nil : MSGNotIncludedIn;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSArray *))excludedFrom {
    return ^(NSArray *array) {
        [self validateClass:[NSObject class] withName:@"excluded from" validationBlock:^NGRMsgKey *(NSObject *value) {
            return [array containsObject:value] ? MSGNotExcludedFrom : nil;
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

- (NGRPropertyValidator *(^)(NSString *))msgNotIncludedIn {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotIncludedIn];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *))msgNotExcludedFrom {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNotExcludedFrom];
        return self;
    };
}

@end
