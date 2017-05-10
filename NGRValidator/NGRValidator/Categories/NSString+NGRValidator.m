//
//  NSString+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSString+NGRValidator.h"
#import "NSDate+NGRValidator.h"
#import "NSCharacterSet+NGRValidator.h"

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
    static NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

    return [self ngr_evaluatePattern:emailRegEx];
}

- (BOOL)ngr_isURLWithScheme:(NSString *)scheme {
    static NSString *urlPathPattern = @"([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSString *urlPattern = [NSString stringWithFormat:@"%@://%@", scheme, urlPathPattern];
    
    return [self ngr_evaluatePattern:urlPattern];
}

- (BOOL)ngr_isFileURL {
    return [[NSURL URLWithString:self] isFileURL];
}

- (BOOL)ngr_isHttpURL {
    return [self ngr_isURLWithScheme:@"http"];
}

- (BOOL)ngr_isHttpsURL {
    return [self ngr_isURLWithScheme:@"https"];
}
    
- (BOOL)ngr_isWebSocketURL {
    return [self ngr_isURLWithScheme:@"ws"];
}
    
- (BOOL)ngr_isSecureWebSocketURL {
    return [self ngr_isURLWithScheme:@"wss"];
}

- (BOOL)ngr_isIPv4 {
    static NSString *pattern = @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isIPv6 {
    static NSString *pattern = @"((^|:)([0-9a-fA-F]{0,4})){1,8}$";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isDomain {
    static NSString *pattern = @"^([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}$";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isUUID {
    static NSString *pattern = @"^[0-9A-Fa-f]{8}\\-[0-9A-Fa-f]{4}\\-[0-9A-Fa-f]{4}\\-[0-9A-Fa-f]{4}\\-[0-9A-Fa-f]{12}$";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isGeoCoordinate {
    static NSString *pattern = @"-?\\d{1,3}\\.\\d+";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isPrice {
    static NSArray<NSString *> *patterns = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        patterns = @[
            @"\\d+(\\.\\d{2})?",
            @"\\d+(,\\d{2})?",
        ];
    });
    
    return [self ngr_evaluateAnyOfPatterns:patterns];
}
    
- (BOOL)ngr_isISBN {
    static NSString *pattern = @"(?:(?=.{17}$)97[89][ -](?:[0-9]+[ -]){2}[0-9]+[ -][0-9]|97[89][0-9]{10}|(?=.{13}$)(?:[0-9]+[ -]){2}[0-9]+[ -][0-9Xx]|[0-9]{9}[0-9Xx])";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isHexColor {
    static NSString *pattern = @"^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$";
    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isPhoneNumber {
    static NSString *pattern = @"^((\\+)|(00))[0-9]{6,14}$";

    return [self ngr_evaluatePattern:pattern];
}
    
- (BOOL)ngr_isPostalCode {
    static NSArray<NSString *> *patterns = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        patterns = @[
            @"(\\d{5}([\\-]\\d{4})?)",
            @"[A-Za-z][0-9][A-Za-z] [0-9][A-Za-z][0-9]",
            @"[0-9]{5}[\\-]?[0-9]{3}",
            @"[0-9]{3,5}",
            @"[1-9][0-9]{3}\\s?[a-zA-Z]{2}",
            @"\\d{3}-\\d{4}",
            @"(L\\s*(-|—|–))\\s*?[\\d]{4}",
            @"[0-9]{2}\\-[0-9]{3}",
            @"((0[1-9]|5[0-2])|[1-4][0-9])[0-9]{3}",
            @"\\d{3}\\s?\\d{2}",
            @"[A-Za-z]{1,2}[0-9Rr][0-9A-Za-z]? [0-9][ABD-HJLNP-UW-Zabd-hjlnp-uw-z]{2}"
        ];
    });
    
    return [self ngr_evaluateAnyOfPatterns:patterns];
}

- (BOOL)ngr_hasEmoji {
    return [self rangeOfCharacterFromSet:[NSCharacterSet emojisCharacterSet]].location != NSNotFound;
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
    
- (BOOL)ngr_evaluateAnyOfPatterns:(NSArray<NSString *> *)patterns {
    for (NSString *pattern in patterns) {
        if ([self ngr_evaluatePattern:pattern]) {
            return YES;
        }
    }
    
    return NO;
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
