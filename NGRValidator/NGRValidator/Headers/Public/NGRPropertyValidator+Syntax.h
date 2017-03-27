//
//  NGRPropertyValidator+Syntax.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

typedef NS_ENUM(NSInteger, NGRSyntax) {
    NGRSyntaxEmail, // validates email syntax.
    NGRSyntaxName, // validates if given string contains only alphabetic signs.
    NGRSyntaxHTTP,  // validates syntax of HTTP url.
    NGRSyntaxHTTPS,
    NGRSyntaxFile, // validates syntax of File url.
    NGRSyntaxIPv4,
    NGRSyntaxIPv6,
    NGRSyntaxDomain,
    NGRSyntaxUUID,
    NGRSyntaxGeoCoord,
    NGRSyntaxPrice,
    NGRSyntaxISBN,
    NGRSyntaxHexColor,
    NGRSyntaxPhoneNumber,
    NGRSyntaxPostalCode,
    NGRSyntaxWebSocket,
    NGRSyntaxSecureWebSocket,
};

@interface NGRPropertyValidator (Syntax)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Rules

/**
 *  Validates that the NSString has given syntax.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^syntax)(NGRSyntax);

/**
 *  Validates that the NSString matches given regex pattern with options.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^regex)(NSString *, NSRegularExpressionOptions);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property has invalid syntax.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongSyntax)(NGRSyntax syntax, NSString *message);

/**
 *  User-defined error message used when validated property do not match given regex.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongRegex)(NSString *message);

NS_ASSUME_NONNULL_END

@end
