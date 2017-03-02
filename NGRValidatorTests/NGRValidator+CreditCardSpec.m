//
//  NGRValidator+CreditCardSpec.m
//  NGRValidator
//

SpecBegin(NGRValidator_CreditCard)

describe(@"Syntax validation", ^{

    testDescriptor(@"credit card's number validator", @"valid credit card's number", @"invalid credit card's number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"4556737586899855", @"231223121332137", 1, ^(NGRPropertyValidator *validator) {
            return validator.creditCard(NGRCreditCardPropertyNumber).msgInvalidCreditCardProperty(NGRCreditCardPropertyNumber, msg);
        });
    });

    testDescriptor(@"credit card's expiration date validator", @"valid credit card's expiration date", @"invalid credit card's expiration date");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"02/23", @"13/11", 1, ^(NGRPropertyValidator *validator) {
            return validator.creditCard(NGRCreditCardPropertyExpirationDate).msgInvalidCreditCardProperty(NGRCreditCardPropertyExpirationDate, msg);
        });
    });
});

SpecEnd
