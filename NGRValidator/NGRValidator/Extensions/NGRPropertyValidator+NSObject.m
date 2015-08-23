//
//  NGRPropertyValidator+NSObject.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+NSObject.h"

@implementation NGRPropertyValidator (NSObject)

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgNil {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGNil];
        return self;
    };
}

@end
