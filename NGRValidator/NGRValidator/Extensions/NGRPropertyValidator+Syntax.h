//
//  NGRPropertyValidator+Syntax.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

typedef NS_ENUM(NSInteger, NGRSyntax) {
    NGRSyntaxEmail,
    NGRSyntaxName,
    NGRSyntaxURL
};

@interface NGRPropertyValidator (Syntax)

#pragma mark - Rules

/**
 *  Validates that the NSString has given syntax.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^syntax)(NGRSyntax);


/**
 *  Validates that the NSString match given regex.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^regex)(NSRegularExpression *);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property has invalid syntax.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^wrongSyntax)(NGRSyntax syntax, NSString *message);

/**
 *  User-defined error message used when validated property do not match given regex.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^wrongRegex)(NSString *message);

@end
