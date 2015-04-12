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
                [self validateSyntaxWithName:@"syntax: URL" block:^NGRMsgKey *(NSString *string) {
                    return [string ngr_isURL] ? nil : MSGNotHTTP;
                }]; break;
                
            default:
                break;
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
            
        default:
            return nil;
    }
}

@end
