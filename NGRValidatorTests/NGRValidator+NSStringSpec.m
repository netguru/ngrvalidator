//
//  NGRValidator+NSStringSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_NSString)

describe(@"NSString validation", ^{
        
    testDescriptor(@"decimal validator", @"valid decimal", @"invalid decimal");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"123456", @"123foo", 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg);
        });
    });

    testDescriptor(@"minLength validator", @"string with required length", @"too short string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo_bar_baz", @"foo", 1, ^(NGRPropertyValidator *validator) {
            return validator.minLength(5).msgTooShort(msg);
        });
    });

    testDescriptor(@"maxLength validator", @"string with required length", @"too long string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", @"foo_bar_baz", 1, ^(NGRPropertyValidator *validator) {
            return validator.maxLength(5).msgTooLong(msg);
        });
    });

    testDescriptor(@"exactLength validator", @"string with correct length", @"too short string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"_foo_", @"foo", 1, ^(NGRPropertyValidator *validator) {
            return validator.exactLength(5).msgNotExactLength(msg);
        });
    });

    testDescriptor(@"exactLength validator", @"string with correct length", @"too long string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"_foo_", @"foo_bar", 1, ^(NGRPropertyValidator *validator) {
            return validator.exactLength(5).msgNotExactLength(msg);
        });
    });

    testDescriptor(@"lengthRange validator", @"string with required length", @"too short string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", @"f", 1, ^(NGRPropertyValidator *validator) {
            return validator.lengthRange(2, 4).msgTooShort(msg).msgTooLong(msg);
        });
    });

    testDescriptor(@"lengthRange validator", @"string with required length", @"too long string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", @"foo_bar", 1, ^(NGRPropertyValidator *validator) {
            return validator.lengthRange(2, 4).msgTooShort(msg).msgTooLong(msg);
        });
    });

    testDescriptor(@"match validator", @"same string", @"different string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"foo", @"bar", 1, ^(NGRPropertyValidator *validator) {
            return validator.match(@"foo").msgNotMatch(msg);
        });
    });

    testDescriptor(@"differ validator", @"different string", @"same string");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"bar", @"foo", 1, ^(NGRPropertyValidator *validator) {
            return validator.differ(@"foo").msgNotDiffer(msg);
        });
    });
});

SpecEnd
