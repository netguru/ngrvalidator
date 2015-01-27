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
    NGRSyntaxURL  // validates syntax of URL.
};

@interface NGRPropertyValidator (Syntax)

#pragma mark - Rules

/**
 *  Validates that the NSString has given syntax.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^syntax)(NGRSyntax);


/**
 *  Validates that the NSString matches given regex.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^regex)(NSRegularExpression *);

/**
 *  Validates that the NSString matches the given regex pattern string.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^regexPattern)(NSString *);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property has invalid syntax.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongSyntax)(NGRSyntax syntax, NSString *message);

/**
 *  User-defined error message used when validated property do not match given regex.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongRegex)(NSString *message);

@end
