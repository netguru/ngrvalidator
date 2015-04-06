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
    
    testDescriptor(@"required validator", @"any value with count selector", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);
        });
    });
    
    testDescriptor(@"required, allowEmpty validator", @"empty value with count selector", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"", nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().allowEmpty().msgNil(msg);
        });
    });
    
    testDescriptor(@"required validator", @"any value with length selector", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[@"foo"], nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);
        });
    });
    
    testDescriptor(@"required, allowEmpty validator", @"empty value with length selector", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[], nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().allowEmpty().msgNil(msg);
        });
    });
    
    testDescriptor(@"required, allowEmpty validator", @"any not countable value", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData([NSSortDescriptor new], nil, 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);
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
    
    /** 2 properties in model test **/
    
    validatorDescriptor = @"when 2 properties do not match eachother, should fail.";
    itShouldBehaveLike(NGRMultiplePropertiesBehavior, ^{
        NGRTestModel *sut = [[NGRTestModel alloc] initWithValue:@"12345" secondValue:@"1234567"];
        NSArray *rules = @[NGRValidate(@"value").required().minLength(5),
                           NGRValidate(@"secondValue").required().match(sut.value)];

        return wrapDataForMultipleProperties(sut, rules, NO);
    });
    
    validatorDescriptor = @"when 2 properties match eachother, should succeed.";
    itShouldBehaveLike(NGRMultiplePropertiesBehavior, ^{
        NGRTestModel *sut = [[NGRTestModel alloc] initWithValue:@"12345" secondValue:@"12345"];
        NSArray *rules = @[NGRValidate(@"value").required().minLength(5),
                           NGRValidate(@"secondValue").required().match(sut.value)];

        return wrapDataForMultipleProperties(sut, rules, YES);
    });
});

SpecEnd
