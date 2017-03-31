//
//  NGRValidator+ConditionsSpec.m
//  NGRValidator
//

SpecBegin(NGRValidator_ConditionSpec)

describe(@"Conditional validation", ^{
    
    testDescriptor(@"matching condition with valid value", @"valid http string", nil);
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"http://www.example.com", NGRSKIP, 1, ^(NGRPropertyValidator *validator) {
            return validator.when(^BOOL{ return YES; }).syntax(NGRSyntaxHTTP).msgWrongSyntax(NGRSyntaxHTTP, msg);
        });
    });
    
    testDescriptor(@"not matching condition with valid value", @"valid http string", nil);
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"http://www.example.com", NGRSKIP, 1, ^(NGRPropertyValidator *validator) {
            return validator.when(^BOOL{ return NO; }).syntax(NGRSyntaxHTTP).msgWrongSyntax(NGRSyntaxHTTP, msg);
        });
    });

    testDescriptor(@"matching condition with invalid value", @"invalid http string", nil);
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(NGRSKIP, @"invalid-http", 1, ^(NGRPropertyValidator *validator) {
            return validator.when(^BOOL{ return YES; }).syntax(NGRSyntaxHTTP).msgWrongSyntax(NGRSyntaxHTTP, msg);
        });
    });

    testDescriptor(@"not matching condition with invalid value", @"invalid http string", nil);
    itShouldBehaveLike(NGRValueBehavior, ^{  
        return wrapData(@"invalid-http", NGRSKIP, 1, ^(NGRPropertyValidator *validator) {
            return validator.when(^BOOL{ return NO; }).syntax(NGRSyntaxHTTP).msgWrongSyntax(NGRSyntaxHTTP, msg);
        });
    });
    
    testDescriptor(@"overwriting conditions and invalid value", @"invalid http string", nil);
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"invalid-http", NGRSKIP, 1, ^(NGRPropertyValidator *validator) {
            return validator.when(^BOOL{ return YES; }).when(^BOOL{ return NO; }).syntax(NGRSyntaxHTTP).msgWrongSyntax(NGRSyntaxHTTP, msg);
        });
    });
    
});

SpecEnd
