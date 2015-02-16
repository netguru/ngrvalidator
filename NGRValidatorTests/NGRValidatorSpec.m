//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidatorSpec)

describe(@"NGRValidatorSpec", ^{
    
    /** Multiple errors test: **/
    
    testDescriptor(@"maxLength and decimal validator", @"decimal with required length", @"to long non-decimal string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"123", @"foo_bar_baz", 2, ^(NGRPropertyValidator *validator) {
            return validator.maxLength(5).decimal().msgNotDecimal(msg).msgTooLong(msg);
        });
    });
    
    /** Emptiness and requirements test: **/
    
    testDescriptor(@"required validator", @"any value", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);;
        });
    });
    
    testDescriptor(@"required validator", @"any value", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);;
        });
    });
    
    testDescriptor(@"required, allowEmpty validator", @"empty value", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"", nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().allowEmpty().msgNil(msg);;
        });
    });
    
    /** Assertion test: **/
    
    failureDescriptor = @"when using NSNumber class in NSString validation, should raise an exception.";
    itShouldBehaveLike(NGRAssertBehavior, ^{
        return wrapAssertData(@10, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg);
        });
    });
    
    failureDescriptor = @"when using NSString class in NSNumber validation, should raise an exception.";
    itShouldBehaveLike(NGRAssertBehavior, ^{
        return wrapAssertData(@"foo", ^(NGRPropertyValidator *validator) {
            return validator.min(10.f).msgTooSmall(msg);
        });
    });
    
    failureDescriptor = @"when using NSString class in NSDate validation, should raise an exception.";
    itShouldBehaveLike(NGRAssertBehavior, ^{
        return wrapAssertData(@"foo", ^(NGRPropertyValidator *validator) {
            return validator.laterThan([NSDate date]).msgNotLaterThan(msg);
        });
    });
    
});

SpecEnd

