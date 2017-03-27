//
//  NGRPropertyValidator+Syntax.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+Syntax.h"
#import "NSString+NGRValidator.h"

typedef NGRMsgKey *(^NGRSyntaxValidationBlock)(NSString *string);

@implementation NGRPropertyValidator (Syntax)

#pragma mark - Rules

- (void)validateSyntaxWithName:(NSString *)name block:(NGRSyntaxValidationBlock)block {
    [self validateClass:[NSString class] withName:name validationBlock:^NGRMsgKey *(NSString *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NGRSyntax))syntax {
    return ^(NGRSyntax aSyntax) {
        
        switch (aSyntax) {
            case NGRSyntaxEmail:
                [self validateSyntaxWithName:@"syntax: email" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isEmail] ? nil : MSGNotEmail;
                }]; break;
                
            case NGRSyntaxName:
                [self validateSyntaxWithName:@"syntax: name" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isName] ? nil : MSGNotName;
                }]; break;
                
            case NGRSyntaxHTTP:
                [self validateSyntaxWithName:@"syntax: HTTP URL" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isHttpURL] ? nil : MSGNotHTTP;
                }]; break;
                
            case NGRSyntaxFile:
                [self validateSyntaxWithName:@"syntax: File URL" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isFileURL] ? nil : MSGNotFile;
                }]; break;
            
            case NGRSyntaxHTTPS:
                [self validateSyntaxWithName:@"syntax: HTTPS URL" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isHttpsURL] ? nil : MSGNotHTTPS;
                }]; break;
            
            case NGRSyntaxWebSocket:
                [self validateSyntaxWithName:@"syntax: Web Socket URL" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isWebSocketURL] ? nil : MSGNotWebSocket;
                }]; break;
            
            case NGRSyntaxSecureWebSocket:
                [self validateSyntaxWithName:@"syntax: Secure Web Socket URL" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isSecureWebSocketURL] ? nil : MSGNotSecureWebSocket;
                }]; break;
            
            case NGRSyntaxIPv4:
                [self validateSyntaxWithName:@"syntax: IPv4" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isIPv4] ? nil : MSGNotIPv4;
                }]; break;
            
            case NGRSyntaxIPv6:
                [self validateSyntaxWithName:@"syntax: IPv6" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isIPv6] ? nil : MSGNotIPv6;
                }]; break;
            
            case NGRSyntaxUUID:
                [self validateSyntaxWithName:@"syntax: UUID" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isUUID] ? nil : MSGNotUUID;
                }]; break;
            
            case NGRSyntaxDomain:
                [self validateSyntaxWithName:@"syntax: Domain" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isDomain] ? nil : MSGNotDomain;
                }]; break;
            
            case NGRSyntaxGeoCoord:
                [self validateSyntaxWithName:@"syntax: GeoCoordinate" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isGeoCoordinate] ? nil : MSGNotGeoCoord;
                }]; break;
            
            case NGRSyntaxPriceWithDot:
                [self validateSyntaxWithName:@"syntax: Price" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isDotSeparatedPrice] ? nil : MSGNotPriceWithDot;
                }]; break;
            
            case NGRSyntaxPriceWithComma:
                [self validateSyntaxWithName:@"syntax: Price" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isCommaSeparatedPrice] ? nil : MSGNotPriceWithComma;
                }]; break;
            
            case NGRSyntaxISBN:
                [self validateSyntaxWithName:@"syntax: ISBN" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isISBN] ? nil : MSGNotISBN;
                }]; break;
            
            case NGRSyntaxHexColor:
                [self validateSyntaxWithName:@"syntax: Hex color" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isHexColor] ? nil : MSGNotHexColor;
                }]; break;
            
            case NGRSyntaxPhoneNumber:
                [self validateSyntaxWithName:@"syntax: Phone number" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isPhoneNumber] ? nil : MSGNotPhoneNumber;
                }]; break;
            
            case NGRSyntaxPostalCode:
                [self validateSyntaxWithName:@"syntax: Postal code" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isPostalCode] ? nil : MSGNotPostalCode;
                }]; break;

        }
        
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *, NSRegularExpressionOptions))regex {
    return ^(NSString *pattern, NSRegularExpressionOptions options) {
        [self validateSyntaxWithName:@"regex" block:^NGRMsgKey *(NSString *string) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
            NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
            return (matches == 1) ? nil : MSGWrongRegex;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgWrongRegex {
    return ^(NSString *message) {
        [self.messages setMessage:message forKey:MSGWrongRegex];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NGRSyntax, NSString *))msgWrongSyntax {
    return ^(NGRSyntax aSyntax, NSString *message) {
        [self.messages setMessage:message forKey:[self errorFromSyntax:aSyntax]];
        return self;
    };
}

- (NGRMsgKey *)errorFromSyntax:(NGRSyntax)syntax {
    switch (syntax) {
        case NGRSyntaxEmail:
            return MSGNotEmail;
        case NGRSyntaxName:
            return MSGNotName;
        case NGRSyntaxHTTP:
            return MSGNotHTTP;
        case NGRSyntaxFile:
            return MSGNotFile;
        case NGRSyntaxIPv4:
            return MSGNotIPv4;
        case NGRSyntaxIPv6:
            return MSGNotIPv6;
        case NGRSyntaxDomain:
            return MSGNotDomain;
        case NGRSyntaxUUID:
            return MSGNotUUID;
        case NGRSyntaxGeoCoord:
            return MSGNotGeoCoord;
        case NGRSyntaxPriceWithComma:
            return MSGNotPriceWithComma;
        case NGRSyntaxPriceWithDot:
            return MSGNotPriceWithDot;
        case NGRSyntaxISBN:
            return MSGNotISBN;
        case NGRSyntaxHexColor:
            return MSGNotHexColor;
        case NGRSyntaxPhoneNumber:
            return MSGNotPhoneNumber;
        case NGRSyntaxPostalCode:
            return MSGNotPostalCode;
        case NGRSyntaxHTTPS:
            return MSGNotHTTPS;
        case NGRSyntaxSecureWebSocket:
            return MSGNotSecureWebSocket;
        case NGRSyntaxWebSocket:
            return MSGNotWebSocket;
    }
}

@end
