//
//  NSString+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSString+NGRValidator.h"

@implementation NSString (NGRValidator)

#pragma mark - Public

- (NSString *)ngr_stringByCapitalizeFirstLetter {
    if (self.length > 0) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];
    }
    return [self capitalizedString];
}

- (BOOL)ngr_isEmail {
    
    // taken from: http://www.cocoawithlove.com/2009/06/verifying-that-string-is-email-address.html
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

    return [self evaluatePattern:emailRegEx];
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

#pragma mark - Private

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
