//
//  NGRValidator+SyntaxSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_Syntax)

describe(@"Syntax validation", ^{
    
    NSString *email = [NGRStringSyntaxProvider email];
    NSString *http = [NGRStringSyntaxProvider http];
    NSString *file = [NGRStringSyntaxProvider file];
    NSString *name = [NGRStringSyntaxProvider name];
    NSString *ipv4 = [NGRStringSyntaxProvider ipv4];
    NSString *ipv6 = [NGRStringSyntaxProvider ipv6];
    NSString *domain = [NGRStringSyntaxProvider domain];
    NSString *uuid = [NGRStringSyntaxProvider uuid];
    NSString *lat = [NGRStringSyntaxProvider lat];
    NSString *price = [NGRStringSyntaxProvider price];
    NSString *ISBN = [NGRStringSyntaxProvider ISBN];
    NSString *hexColor = [NGRStringSyntaxProvider hexColor];
    NSString *phone = [NGRStringSyntaxProvider phone];
    NSString *https = [NGRStringSyntaxProvider https];
    NSString *postalCode = [NGRStringSyntaxProvider postalCode];
    NSString *webSocket = [NGRStringSyntaxProvider webSocket];
    NSString *secureWebSocket = [NGRStringSyntaxProvider secureWebSocket];
    
    NSArray<NGRSyntaxTestData *> *allCases = @[
        [NGRSyntaxTestData test:@"HTTP" syntax:NGRSyntaxHTTP valid:http invalid:https],
        [NGRSyntaxTestData test:@"File" syntax:NGRSyntaxFile valid:file invalid:https],
        [NGRSyntaxTestData test:@"Email" syntax:NGRSyntaxEmail valid:email invalid:https],
        [NGRSyntaxTestData test:@"Name" syntax:NGRSyntaxName valid:name invalid:https],
        [NGRSyntaxTestData test:@"IPv4" syntax:NGRSyntaxIPv4 valid:ipv6 invalid:https],
        [NGRSyntaxTestData test:@"IPv6" syntax:NGRSyntaxIPv6 valid:ipv4 invalid:https],
        [NGRSyntaxTestData test:@"Domain" syntax:NGRSyntaxDomain valid:domain invalid:https],
        [NGRSyntaxTestData test:@"UUID" syntax:NGRSyntaxUUID valid:uuid invalid:https],
        [NGRSyntaxTestData test:@"Geo Coordinate" syntax:NGRSyntaxGeoCoord valid:lat invalid:https],
        [NGRSyntaxTestData test:@"Price" syntax:NGRSyntaxPrice valid:price invalid:https],
        [NGRSyntaxTestData test:@"ISBN" syntax:NGRSyntaxISBN valid:ISBN invalid:https],
        [NGRSyntaxTestData test:@"Hex color" syntax:NGRSyntaxHexColor valid:hexColor invalid:https],
        [NGRSyntaxTestData test:@"Phone number" syntax:NGRSyntaxPhoneNumber valid:phone invalid:https],
        [NGRSyntaxTestData test:@"Postal code" syntax:NGRSyntaxPostalCode valid:postalCode invalid:https],
        [NGRSyntaxTestData test:@"HTTPS" syntax:NGRSyntaxHTTPS valid:https invalid:http],
        [NGRSyntaxTestData test:@"WebSocket" syntax:NGRSyntaxWebSocket valid:webSocket invalid:https],
        [NGRSyntaxTestData test:@"SecureWebSocket" syntax:NGRSyntaxSecureWebSocket valid:secureWebSocket invalid:https],
    ];
    
    for (NGRSyntaxTestData *test in allCases) {
        testDescriptor(test.name, @"valid syntax", @"invalid syntax");
        itShouldBehaveLike(NGRValueBehavior, ^{
            return wrapData(test.valid, test.invalid, 1, ^(NGRPropertyValidator *validator) {
                return validator.syntax(test.syntax).msgWrongSyntax(test.syntax, msg);
            });
        });
    }
    
    testDescriptor(@"regex validator", @"valid regex syntax", @"invalid regex syntax");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(@"QUX", @"b4z", 1, ^(NGRPropertyValidator *validator) {
            return validator.regex(@"q.*", NSRegularExpressionCaseInsensitive).msgWrongRegex(msg);
        });
    });
});

SpecEnd
