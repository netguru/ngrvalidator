//
//  NSString+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSString+NGRValidator.h"

@implementation NSString (NGRValidator)

#pragma mark - Public Methods

- (BOOL)ngr_isEmail {
    return [self evaluatePattern:@".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"];
}

- (BOOL)ngr_isURL {
    return [self evaluatePattern:@"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"];
}

- (BOOL)ngr_isName {
    return [self evaluateAllowedCharacterSet:[NSCharacterSet letterCharacterSet]];
}

- (BOOL)ngr_isDecimal {
    return [self evaluateAllowedCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
}

#pragma mark - Private Methods

- (BOOL)evaluatePattern:(NSString *)pattern {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

- (BOOL)evaluateAllowedCharacterSet:(NSCharacterSet *)allowedCharacterSet {
    NSCharacterSet *set = [allowedCharacterSet invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:set];
    return (range.location == NSNotFound);
}

@end
