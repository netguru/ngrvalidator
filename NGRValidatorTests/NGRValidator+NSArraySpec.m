//
//  NGRValidator+NSArraySpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 20/08/15.
//
//

SpecBegin(NGRValidator_NSArray)

describe(@"Array validation", ^{
    
    /** includes validator **/
    
    testDescriptor(@"includes validator", @"value is included", @"array is empty");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[@10], @[], 1, ^(NGRPropertyValidator *validator) {
            return validator.includes(@10).msgNotIncludes(msg);
        });
    });
    
    testDescriptor(@"includes validator", @"value is included", @"array contains other values");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[@"fixture.string"], @[@"invalid.fixture.string.1", @"invalid.fixture.string.2"], 1, ^(NGRPropertyValidator *validator) {
            return validator.includes(@"fixture.string").msgNotIncludes(msg);
        });
    });
    
    testDescriptor(@"includes validator", @"value is not included but is array allowed to be empty", @"any other value");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[], @[@[@101]], 1, ^(NGRPropertyValidator *validator) {
            return validator.includes(@[@10]).allowEmpty().msgNotIncludes(msg);
        });
    });
    
    
    /** excludes validator **/
    
    testDescriptor(@"excludes validator", @"value is excluded", @"array is empty");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[@11], @[], 1, ^(NGRPropertyValidator *validator) {
            return validator.excludes(@10).msgNotExcludes(msg);
        });
    });
    
    testDescriptor(@"excludes validator", @"value is excluded", @"array contains some values");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[@"fixture.string.1"], @[@"fixture.string.1", @"fixture.string.2"], 1, ^(NGRPropertyValidator *validator) {
            return validator.excludes(@"fixture.string.2").msgNotExcludes(msg);
        });
    });

    testDescriptor(@"excludes validator", @"array is empty and is allowed to be empty", @"is included");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[], @[@[@10]], 1, ^(NGRPropertyValidator *validator) {
            return validator.excludes(@[@10]).allowEmpty().msgNotExcludes(msg);
        });
    });
    
    
    /** included in validator **/
    
    testDescriptor(@"includedIn validator", @"value is only one object in array", @"array is empty");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@11, @[], 1, ^(NGRPropertyValidator *validator) {
            return validator.includedIn(@[@11]).msgNotIncludedIn(msg);
        });
    });
    
    testDescriptor(@"includedIn validator", @"value is one from multiple objects in array", @"value is not in array");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"fixture.string.1", @"fixture.string.3", 1, ^(NGRPropertyValidator *validator) {
            return validator.includedIn(@[@"fixture.string.1", @"fixture.string.2"]).msgNotIncludedIn(msg);
        });
    });
    
    testDescriptor(@"includedIn validator", @"NGRSKIP", @"array is empty");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(NGRSKIP, @"fixture.string.3", 1, ^(NGRPropertyValidator *validator) {
            return validator.includedIn(@[]).msgNotIncludedIn(msg);
        });
    });
    
    
    /** excluded from validator **/
    
    testDescriptor(@"excludedFrom validator", @"value is not in an array", @"value is in array");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@[], @11, 1, ^(NGRPropertyValidator *validator) {
            return validator.excludedFrom(@[@11]).msgNotExcludedFrom(msg);
        });
    });
    
    testDescriptor(@"excludedFrom validator", @"value is not in array", @"value is one from multiple objects in array");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"fixture.string.3", @"fixture.string.1", 1, ^(NGRPropertyValidator *validator) {
            return validator.excludedFrom(@[@"fixture.string.1", @"fixture.string.2"]).msgNotExcludedFrom(msg);
        });
    });

    testDescriptor(@"excludedFrom validator", @"NGRSKIP", @"array is empty");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"fixture.string.3", NGRSKIP, 0, ^(NGRPropertyValidator *validator) {
            return validator.excludedFrom(@[]).msgNotExcludedFrom(msg);
        });
    });
});

SpecEnd
