//
//  NGRValidator_SyntaxSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_SyntaxSpec)

describe(@"Syntax validation", ^{

    testDescriptor(@"syntax Email validator", @"valid email syntax", @"wrong email syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"email@example.com", @"email@.", 1, ^(NGRPropertyValidator *validator) {
            return validator.syntax(NGRSyntaxEmail).msgWrongSyntax(NGRSyntaxEmail, msg);
        });
    });
    
    testDescriptor(@"regex validator", @"valid regex syntax", @"wrong regex syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"QUX", @"b4z", 1, ^(NGRPropertyValidator *validator) {
            return validator.regex(@"q.*", NSRegularExpressionCaseInsensitive).msgWrongRegex(msg);
        });
    });
    
    testDescriptor(@"syntax URL", @"valid url syntax", @"wrong url syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"http://www.google.com", @"http://bar", 1, ^(NGRPropertyValidator *validator) {
            return validator.syntax(NGRSyntaxURL).msgWrongSyntax(NGRSyntaxURL, msg);
        });
    });
    
});

SpecEnd

