//
//  NSString+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSString+NGRValidator.h"
#import "NSDate+NGRValidator.h"

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

    return [self ngr_evaluatePattern:emailRegEx];
}

- (BOOL)ngr_isURL {
    return [self ngr_evaluatePattern:@"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"];
}

- (BOOL)ngr_isName {
    return [self ngr_evaluateAllowedCharacterSet:[NSCharacterSet letterCharacterSet]];
}

- (BOOL)ngr_isDecimal {
    return [self ngr_evaluateAllowedCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
}


- (BOOL)ngr_isValidCreditCardNumber {
    NSString *stringWithoutSpaces = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *number = [stringWithoutSpaces stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];

    if (![number ngr_isDecimal]) {
        return NO;
    }

    if ([number length] < 12 || [number length] > 19) {
        return NO;
    }

    return [number ngr_fulfillsLuhnAlgorithm];
}

- (BOOL)ngr_isValidCreditCardExpirationDate {

    NSArray<NSString *> *components = [self componentsSeparatedByString:@"/"];

    if ([components count] != 2) {
        return NO;
    }

    if (
        ([components[0] length] != 2) ||
        ![components[0] ngr_isDecimal] ||
        ([components[1] length] != 2) ||
        ![components[1] ngr_isDecimal]
        ) {
        return NO;
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/yy"];
    NSDate *expirationDate = [formatter dateFromString:self];

    if (expirationDate == nil) {
        return NO;
    }

    NSDate *endOfMonth = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:expirationDate options:0];

    return [endOfMonth ngr_isLaterThan:[[NSDate alloc] init]];
}

#pragma mark - Private

- (BOOL)ngr_evaluatePattern:(NSString *)pattern {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

- (BOOL)ngr_evaluateAllowedCharacterSet:(NSCharacterSet *)allowedCharacterSet {
    NSCharacterSet *set = [allowedCharacterSet invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:set];
    return (range.location == NSNotFound);
}

- (BOOL)ngr_fulfillsLuhnAlgorithm {

    // Luhn algorithm

    NSMutableArray<NSNumber *> *digits = [[NSMutableArray alloc] initWithCapacity:[self length]];
    for (int i = 0; i < [self length]; i++) {
        NSString *character = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
        [digits addObject:[NSNumber numberWithInteger:[character integerValue]]];

    }

    // Store last digit
    NSNumber *lastDigit = [digits lastObject];

    // Drop the last digit:
    [digits removeLastObject];

    // Multiple odd digits by 2  &&  Subtract 9 to numbers over 9:
    for (int i = 0; i < [digits count]; i++) {
        if (!(i % 2)) {
            digits[i] = [NSNumber numberWithInteger: [digits[i] integerValue] * 2];
        }
        if ([digits[i] integerValue] > 9) {
            digits[i] = [NSNumber numberWithInteger: [digits[i] integerValue] - 9];
        }
    }

    // Add all numbers:
    int sum = 0;
    for (id number in [digits objectEnumerator]) {
        sum += [number integerValue];
    }

    // Multiply by 9 && Mod 10:
    int result = sum * 9 % 10;

    return result == [lastDigit integerValue];
}

@end
