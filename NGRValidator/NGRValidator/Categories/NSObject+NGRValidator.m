//
//  NSObject+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 03.01.2015.
//
//

#import "NSObject+NGRValidator.h"

@implementation NSObject (NGRValidator)

- (BOOL)ngr_isEmpty {
    
    if ([self respondsToSelector:@selector(count)]) {
        return [self performSelector:@selector(count)] == 0;
        
    } else if ([self respondsToSelector:@selector(length)]) {
        return [self performSelector:@selector(length)] == 0;
    }
    return YES;
}

- (BOOL)ngr_isCountable {
    return [self respondsToSelector:@selector(count)] || [self respondsToSelector:@selector(length)];
}

@end
