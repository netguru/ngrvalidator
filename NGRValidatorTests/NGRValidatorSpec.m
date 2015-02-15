//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidatorSpec)

describe(@"NGRValidator class", ^{
    
    /*****************************        Strings       *********************************/
    
    describe(@"with NSString", ^{
        
        testDescriptor = @"decimal validator";
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"123456", @"123foo", 1, ^(NGRPropertyValidator *validator) {
                return validator.decimal().msgNotDecimal(msg);
            });
        });
        
        testDescriptor = @"minLength validator";
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"foo_bar_baz", @"foo", 1, ^(NGRPropertyValidator *validator) {
                return validator.minLength(5).msgTooShort(msg);
            });
        });
        
        testDescriptor = @"maxLength validator";
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"foo", @"foo_bar_baz", 1, ^(NGRPropertyValidator *validator) {
                return validator.maxLength(5).msgTooLong(msg);
            });
        });
        
        testDescriptor = @"exactLength validator"; //testing too short string
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"_foo_", @"foo", 1, ^(NGRPropertyValidator *validator) {
                return validator.exactLength(5).msgNotExactLength(msg);
            });
        });
        
        testDescriptor = @"exactLength validator (2nd)"; //testing too long string
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"_foo_", @"foo_bar", 1, ^(NGRPropertyValidator *validator) {
                return validator.exactLength(5).msgNotExactLength(msg);
            });
        });
        
        testDescriptor = @"lengthRange validator"; //testing too short string
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"foo", @"f", 1, ^(NGRPropertyValidator *validator) {
                return validator.lengthRange(2, 4).msgTooShort(msg).msgTooLong(msg);
            });
        });
        
        testDescriptor = @"lengthRange validator (2nd)"; //testing too long string
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"foo", @"foo_bar", 1, ^(NGRPropertyValidator *validator) {
                return validator.lengthRange(2, 4).msgTooShort(msg).msgTooLong(msg);
            });
        });
        
        testDescriptor = @"match validator";
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"foo", @"bar", 1, ^(NGRPropertyValidator *validator) {
                return validator.match(@"foo").msgNotMatch(msg);
            });
        });
        
        testDescriptor = @"differ validator";
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@"bar", @"foo", 1, ^(NGRPropertyValidator *validator) {
                return validator.differ(@"foo").msgNotDiffer(msg);
            });
        });
    });
    
    /*****************************        Numbers       *********************************/
    
    describe(@"with NSNumber", ^{
        
        testDescriptor = @"min validator";
        itShouldBehaveLike(NGRBehavior, ^{
            return wrapData(@100, @10, 1, ^(NGRPropertyValidator *validator) {
                return validator.min(50.f).msgTooSmall(msg);
            });
        });
    });
    
    
});

SpecEnd

