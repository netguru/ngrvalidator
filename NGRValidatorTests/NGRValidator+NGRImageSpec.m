//
//  NGRValidator+NGRImageSpec.m
//  NGRValidator
//

SpecBegin(NGRValidator_NGRImage)

describe(@"Syntax validation", ^{
    
    NGRImage *valid = [NGRImage ngr_imageWithSize:CGSizeMake(10.0, 10.0)];
    NGRImage *tooSmall = [NGRImage ngr_imageWithSize:CGSizeMake(2.0, 5.0)];
    NGRImage *tooBig = [NGRImage ngr_imageWithSize:CGSizeMake(50.0, 20.0)];
    
    testDescriptor(@"image max size validation", @"valid size", @"invalid size");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooBig, 1, ^(NGRPropertyValidator *validator) {
            return validator.maxSize(CGSizeMake(10.0, 10.0)).msgImageTooBig(msg);
        });
    });
    
    testDescriptor(@"image min size validation", @"valid size", @"invalid size");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooSmall, 1, ^(NGRPropertyValidator *validator) {
            return validator.minSize(CGSizeMake(10.0, 10.0)).msgImageTooSmall(msg);
        });
    });
    
    testDescriptor(@"image max width validation", @"valid width", @"invalid width");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooBig, 1, ^(NGRPropertyValidator *validator) {
            return validator.maxWidth(10.0).msgImageTooBig(msg);
        });
    });
    
    testDescriptor(@"image min width validation", @"valid width", @"invalid width");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooSmall, 1, ^(NGRPropertyValidator *validator) {
            return validator.minWidth(10.0).msgImageTooSmall(msg);
        });
    });
    
    testDescriptor(@"image max height validation", @"valid height", @"invalid height");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooBig, 1, ^(NGRPropertyValidator *validator) {
            return validator.maxHeight(10.0).msgImageTooBig(msg);
        });
    });
    
    testDescriptor(@"image min height validation", @"valid height", @"invalid height");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooSmall, 1, ^(NGRPropertyValidator *validator) {
            return validator.minHeight(10.0).msgImageTooSmall(msg);
        });
    });
    
    testDescriptor(@"image max ratio validation", @"valid ratio", @"invalid ratio");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooBig, 1, ^(NGRPropertyValidator *validator) {
            return validator.maxRatio(1.0).msgWrongRatio(msg);
        });
    });
    
    testDescriptor(@"image min ratio validation", @"valid ratio", @"invalid ratio");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(valid, tooSmall, 1, ^(NGRPropertyValidator *validator) {
            return validator.minRatio(1.0).msgWrongRatio(msg);
        });
    });
    
});

SpecEnd
