//
//  NGRPropertyValidator+NSObject.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSObject.h"

@implementation NGRPropertyValidator (NSObject)

#pragma mark - Rules

- (NGRPropertyValidator *(^)(NSArray *))includedIn {
    return ^(NSArray *array) {
        [self validateClass:[NSObject class] withName:@"includedIn" validationBlock:^NGRMsgKey *(NSObject *value) {
            return [array containsObject:value] ? nil : MSGNotIncludedIn;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSArray *))excludedFrom {
    return ^(NSArray *array) {
        [self validateClass:[NSObject class] withName:@"includedIn" validationBlock:^NGRMsgKey *(NSObject *value) {
            return [array containsObject:value] ? MSGNotExcludedFrom : nil;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgNil {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNil];
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
