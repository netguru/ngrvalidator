//
//  NGRPropertyValidator.m
//  NGRValidator
//

#import "NGRPropertyValidator+CreditCard.h"
#import "NSString+NGRValidator.h"

typedef NGRMsgKey *(^NGRSyntaxValidationBlock)(NSString *string);

@implementation NGRPropertyValidator (CreditCard)

#pragma mark - Rules

- (void)validatePropertyWithName:(NSString *)name block:(NGRSyntaxValidationBlock)block {
    [self validateClass:[NSString class] withName:name validationBlock:^NGRMsgKey *(NSString *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NGRCreditCardProperty))creditCard {
    return ^(NGRCreditCardProperty aProperty) {

        switch (aProperty) {
            case NGRCreditCardPropertyNumber:
                [self validatePropertyWithName:@"credit card: numer" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isValidCreditCardNumber] ? nil : MSGNotValidCreditCardNumber;
                }]; break;

            case NGRCreditCardPropertyExpirationDate:
                [self validatePropertyWithName:@"credit card: expiration date" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isValidCreditCardExpirationDate] ? nil : MSGNotValidCreditCardExpirationDate;
                }]; break;

            default:
                break;
        }

        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NGRCreditCardProperty, NSString *))msgInvalidCreditCardProperty {
    return ^(NGRCreditCardProperty aProperty, NSString *message) {
        [self.messages setMessage:message forKey:[self errorFromProperty:aProperty]];
        return self;
    };
}

- (NGRMsgKey *)errorFromProperty:(NGRCreditCardProperty)property {
    switch (property) {
        case NGRCreditCardPropertyNumber:
            return MSGNotValidCreditCardNumber;
        case NGRCreditCardPropertyExpirationDate:
            return MSGNotValidCreditCardExpirationDate;

        default:
            return nil;
    }
}

@end
