//
//  NGRValidator+SyntaxSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_Syntax)

describe(@"Syntax validation", ^{

    testDescriptor(@"syntax Email validator", @"valid email syntax", @"invalid email syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"email@domain.international", @"email@.", 1, ^(NGRPropertyValidator *validator) {
            return validator.syntax(NGRSyntaxEmail).msgWrongSyntax(NGRSyntaxEmail, msg);
        });
    });
    
    testDescriptor(@"syntax HTTP URL validator", @"valid http url syntax", @"invalid http url syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"http://www.google.com", @"http://bar", 1, ^(NGRPropertyValidator *validator) {
            return validator.syntax(NGRSyntaxHTTP).msgWrongSyntax(NGRSyntaxHTTP, msg);
        });
    });
    
    testDescriptor(@"syntax File URL validator", @"valid file url syntax", @"invalid file url syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"file://www.google.com", @"http://bar", 1, ^(NGRPropertyValidator *validator) {
            return validator.syntax(NGRSyntaxFile).msgWrongSyntax(NGRSyntaxFile, msg);
        });
    });
    
    testDescriptor(@"syntax Name validator", @"valid name", @"invalid name");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"Foo", @"Foo12", 1, ^(NGRPropertyValidator *validator) {
            return validator.syntax(NGRSyntaxName).msgWrongSyntax(NGRSyntaxName, msg);
        });
    });
    
    testDescriptor(@"regex validator", @"valid regex syntax", @"invalid regex syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"QUX", @"b4z", 1, ^(NGRPropertyValidator *validator) {
            return validator.regex(@"q.*", NSRegularExpressionCaseInsensitive).msgWrongRegex(msg);
        });
    });
});

SpecEnd
