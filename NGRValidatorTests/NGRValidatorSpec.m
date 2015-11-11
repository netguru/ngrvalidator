//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator)

describe(@"NGRValidator", ^{
    
    /** Multiple errors test: **/
    
    testDescriptor(@"maxLength and decimal validator", @"decimal with required length", @"to long non-decimal string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"123", @"foo_bar_baz", 2, ^(NGRPropertyValidator *validator) {
            return validator.maxLength(5).decimal().msgNotDecimal(msg).msgTooLong(msg);
        });
    });
    
    /** Emptiness and requirements test: **/
    
    testDescriptor(@"required validator", @"any value with count selector", @"empty value");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", @"", 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);
        });
    });
    
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
    
    testDescriptor(@"allowEmpty validator", @"empty value with count selector", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(nil, NGRSKIP, 1, ^(NGRPropertyValidator *validator) {
            return validator.minLength(4).msgTooShort(msg).allowEmpty();
        });
    });

    testDescriptor(@"required validator", @"any value with length selector", @"nil");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[@"foo"], @[], 1, ^(NGRPropertyValidator *validator) {
            return validator.required().msgNil(msg);
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
    
    context(@"", ^{
        
        __block NGRTestModel *model;
        __block NSError *error;
        
        beforeEach(^{
            model = [[NGRTestModel alloc] init];
            error = nil;
        });
        
        /** 2 properties in model test **/
        
        validatorDescriptor = @"when 2 properties do not match eachother, should fail.";
        itShouldBehaveLike(NGRMultiplePropertiesBehavior, ^{
            model.value = @"12345";
            model.secondValue = @"1234567";
            NSArray *rules = @[NGRValidate(@"value").required().minLength(5),
                               NGRValidate(@"secondValue").required().match(model.value)];
            
            return wrapDataForMultipleProperties(model, rules, NO);
        });
        
        validatorDescriptor = @"when 2 properties match eachother, should succeed.";
        itShouldBehaveLike(NGRMultiplePropertiesBehavior, ^{
            model.value = @"12345";
            model.secondValue = @"12345";
            NSArray *rules = @[NGRValidate(@"value").required().minLength(5),
                               NGRValidate(@"secondValue").required().match(model.value)];
            
            return wrapDataForMultipleProperties(model, rules, YES);
        });
        
        context(@"when using delegate for error messages", ^{
            
            beforeEach(^{
                model.value = @"foo";
                model.secondValue = @"foo";
            });
            
            it(@"if property and message exist in dictionary, should return customize message.", ^{
                [NGRValidator validateModel:model error:&error delegate:model rules:^NSArray *{
                    return @[NGRValidate(@"value").required().minLength(10)];
                }];
                expect(error.localizedDescription).to.equal(@"Fixture too short message");
            });
            
            it(@"if property exist and message doesn't exist in dictionary, should return default message.", ^{
                [NGRValidator validateModel:model error:&error delegate:model rules:^NSArray *{
                    return @[NGRValidate(@"value").required().maxLength(1)];
                }];
                expect(error.localizedDescription).to.equal(@"Value is too long.");
            });
            
            it(@"if property doesn't exist in dictionary, should return default message.", ^{
                [NGRValidator validateModel:model error:&error delegate:model rules:^NSArray *{
                    return @[NGRValidate(@"secondValue").required().maxLength(1)];
                }];
                expect(error.localizedDescription).to.equal(@"SecondValue is too long.");
            });
        });
    });
});

SpecEnd
