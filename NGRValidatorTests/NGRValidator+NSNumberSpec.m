//
//  NGRValidator+NSNumberSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_NSNumber)

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

    testDescriptor(@"max validator", @"smaller number", @"too big number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@1.23f, @200.23f, 1, ^(NGRPropertyValidator *validator) {
            return validator.max(100.23f).msgTooBig(msg);
        });
    });

    testDescriptor(@"max validator", @"exact negative number", @"too big, negative number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@(-100.23f), @(-50.23f), 1, ^(NGRPropertyValidator *validator) {
            return validator.max(-100.23f).msgTooBig(msg);
        });
    });

    testDescriptor(@"exact validator", @"expected  number", @"too big number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@100.23f, @200.23f, 1, ^(NGRPropertyValidator *validator) {
            return validator.exact(100.23f).msgNotExact(msg);
        });
    });

    testDescriptor(@"exact validator", @"expected negative number", @"too small number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@(-100.23f), @(-150.23f), 1, ^(NGRPropertyValidator *validator) {
            return validator.exact(-100.23f).msgNotExact(msg);
        });
    });

    testDescriptor(@"range validator", @"expected  number", @"too big number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@100.23f, @200.23f, 1, ^(NGRPropertyValidator *validator) {
            return validator.range(50.23f, 150.23f).msgTooBig(msg).msgTooSmall(msg);
        });
    });

    testDescriptor(@"range validator", @"expected negative number", @"too small number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@(-100.23f), @(-200.23f), 1, ^(NGRPropertyValidator *validator) {
            return validator.range(-150.23f, -50.23f).msgTooBig(msg).msgTooSmall(msg);
        });
    });

    testDescriptor(@"beTrue validator", @"true", @"false");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@YES, @NO, 1, ^(NGRPropertyValidator *validator) {
            return validator.beTrue().msgNotTrue(msg);
        });
    });

    testDescriptor(@"beTrue validator", @"TRUE represented by number", @"FALSE represented by number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@100, @0, 1, ^(NGRPropertyValidator *validator) {
            return validator.beTrue().msgNotTrue(msg);
        });
    });

    testDescriptor(@"beFalse validator", @"false", @"true");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@NO, @YES, 1, ^(NGRPropertyValidator *validator) {
            return validator.beFalse().msgNotFalse(msg);
        });
    });

    testDescriptor(@"beFalse validator", @"FALSE represented by number", @"TRUE represented by number");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@0, @(-100), 1, ^(NGRPropertyValidator *validator) {
            return validator.beFalse().msgNotFalse(msg);
        });
    });
});

SpecEnd
