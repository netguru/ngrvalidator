//
//  NSObject+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 03.01.2015.
//
//

#import "NSObject+NGRValidator.h"
#import <objc/runtime.h>

@implementation NSObject (NGRValidator)

#pragma mark - Public

- (BOOL)ngr_isEmpty {

    if ([self ngr_containsCountProperty]) {
        return [self performSelector:@selector(count)] == 0;
        
    } else if ([self ngr_containsLengthProperty]) {
        return [self performSelector:@selector(length)] == 0;
    }
    
    return NO;
}

- (BOOL)ngr_isCountable {
    return [self ngr_containsCountProperty] || [self ngr_containsLengthProperty];
}

#pragma mark - Private

- (BOOL)ngr_containsCountProperty {
    return [self ngr_isOneFromClasses:@[
        [NSArray class],
        [NSMutableArray class],
        [NSSet class],
        [NSMutableSet class],
        [NSDictionary class],
        [NSMutableDictionary class]
    ]];
}

- (BOOL)ngr_containsLengthProperty {
    return [self ngr_isOneFromClasses:@[
        [NSString class],
        [NSMutableString class],
        [NSAttributedString class],
        [NSMutableAttributedString class],
        [NSData class],
        [NSMutableData class]
    ]];
}

- (BOOL)ngr_isOneFromClasses:(NSArray *)classes {
    NSUInteger index = [classes indexOfObjectPassingTest:^BOOL(Class aClass, NSUInteger idx, BOOL *stop) {
        return [self isKindOfClass:aClass];
    }];
    return index != NSNotFound;
}

@end
