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
    NGRSyntaxHTTPS, // validates syntax of HTTPS url.
    NGRSyntaxFile, // validates syntax of File url.
    NGRSyntaxIPv4, // validates syntax of IPv4.
    NGRSyntaxIPv6, // validates syntax of IPv6.
    NGRSyntaxDomain, // validates syntax of domain like example.com.
    NGRSyntaxUUID, // validates syntax of UUID.
    NGRSyntaxGeoCoord, // validates syntax of lattitude or lontitude.
    NGRSyntaxPrice, // validates syntax price (comma or dot separated).
    NGRSyntaxISBN, // validates syntax of ISBN.
    NGRSyntaxHexColor, // validates syntax of a hex color.
    NGRSyntaxPhoneNumber, // validates syntax of phone number (without separators).
    NGRSyntaxPostalCode, // validates syntax of various postal code formats.
    NGRSyntaxWebSocket, // validates syntax of web socket url (ws).
    NGRSyntaxSecureWebSocket, // validates syntax of secure web socket url (wss).
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
