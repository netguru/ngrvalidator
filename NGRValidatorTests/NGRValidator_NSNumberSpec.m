//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_NSNumberSpec)

describe(@"NSNumber validation", ^{

    testDescriptor(@"min validator", @"bigger number", @"too small number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@200.23f, @1.23f, 1, ^(NGRPropertyValidator *validator) {
            return validator.min(100.23f).msgTooSmall(msg);
        });
    });

    testDescriptor(@"min validator", @"exact negative number", @"too small, negative number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@(-100.23f), @(-200.23f), 1, ^(NGRPropertyValidator *validator) {
            return validator.min(-100.23f).msgTooSmall(msg);
        });
    });
    
});

SpecEnd

