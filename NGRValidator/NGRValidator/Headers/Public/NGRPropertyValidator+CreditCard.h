//
//  NGRPropertyValidator+CreditCard.h
//  NGRValidator
//

#import "NGRPropertyValidator.h"

typedef NS_ENUM(NSInteger, NGRCreditCardProperty) {
    NGRCreditCardPropertyNumber, // validates credit card's number.
    NGRCreditCardPropertyExpirationDate, // validates credit card's expiration date.
};

@interface NGRPropertyValidator (CreditCard)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Rules

/**
 *  Validates that the NSString is valid credit card property.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^creditCard)(NGRCreditCardProperty);

#pragma mark - Messaging

/**
 *  User-defined error message used when credit card's property is invalid.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgInvalidCreditCardProperty)(NGRCreditCardProperty property, NSString *message);

NS_ASSUME_NONNULL_END

@end
