//
//  NGRPropertyValidator+Collection.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21.02.2015.
//
//

#import "NGRPropertyValidator+Collection.h"

typedef NGRError (^NGRCollectionValidationBlock)(NSString *string);

@implementation NGRPropertyValidator (Collection)

#pragma mark - Rules

- (void)validateCollectionWithName:(NSString *)name block:(NGRCollectionValidationBlock)block {
    [self validateClass:[NSString class] withName:name validationBlock:^NGRError(NSString *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(id value))includes {
    return ^(id value) {
//        [self validateStringWithName:@"minimum length" block:^NGRError(NSString *string) {
//            return (string.length < min) ? NGRErrorTooShort : NGRErrorNoone;
//        }];
        return self;
    };
}

@end
