//
//  NSArray+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSArray+NGRValidator.h"
#import "NGRPropertyValidator.h"

@implementation NSArray (NGRValidator)

#pragma mark - Public

- (BOOL)ngr_containsString:(NSString *)string {
    for (NSString *str in self) {
        if ([str isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)ngr_sortedArrayByPriority {
    return [self sortedArrayUsingComparator:^NSComparisonResult(NGRPropertyValidator *validatorA, NGRPropertyValidator *validatorB) {
        return [@(validatorA.priority) compare:@(validatorB.priority)];
    }];
}

@end
