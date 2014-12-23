//
//  NSArray+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSArray+NGRValidator.h"

@implementation NSArray (NGRValidator)

- (BOOL)ngr_containsString:(NSString *)string {
    for (NSString *str in self) {
        if ([str isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

@end
