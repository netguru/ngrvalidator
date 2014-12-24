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

- (NGRPropertyValidator *(^)(id, SEL, NSString *))condition {
    return ^(id target, SEL selector, NSString *message) {
        [self validateClass:nil withBlock:^NGRError(id value) {
            
            if (message) {
                [self setMessage:message forError:NGRErrorCustomCondition];
            }
            
            BOOL valid = NO;
            if (target && [target respondsToSelector:selector]) {
                
                NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
                BOOL returnsBoolean = strcmp (signature.methodReturnType, @encode(BOOL)) == 0;
                NSAssert(returnsBoolean, @"[NGValidator] Custom validation method has to return BOOL.");
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                valid = [target performSelector:selector];
#pragma clang diagnostic pop
            } else {
                NSAssert(NO, @"[NGValidator] Selector \"%@\" not found in %@ class.", NSStringFromSelector(selector), NSStringFromClass([target class]));
            }
            return valid ? NGRErrorNoone : NGRErrorCustomCondition;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))isNil {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorRequired];
        return self;
    };
}

@end
