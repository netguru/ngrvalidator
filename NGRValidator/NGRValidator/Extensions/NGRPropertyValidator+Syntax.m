//
//  NGRPropertyValidator+Syntax.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator+Syntax.h"
#import "NSString+NGRValidator.h"

typedef NGRError (^NGRSyntaxValidationBlock)(NSString *string);

@implementation NGRPropertyValidator (Syntax)

#pragma mark - Rules

- (void)validateSyntaxWithName:(NSString *)name block:(NGRSyntaxValidationBlock)block {
    [self validateClass:[NSString class] withName:name validationBlock:^NGRError(NSString *value) {
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NGRSyntax))syntax {
    return ^(NGRSyntax aSyntax) {
        
        switch (aSyntax) {
            case NGRSyntaxEmail:
                [self validateSyntaxWithName:@"syntax: email" block:^NGRError(NSString *string) {
                    return [string ngr_isEmail] ? NGRErrorNoone : NGRErrorNotEmail;
                }]; break;
                
            case NGRSyntaxName:
                [self validateSyntaxWithName:@"syntax: name" block:^NGRError(NSString *string) {
                    return [string ngr_isName] ? NGRErrorNoone : NGRErrorNotName;
                }]; break;
                
            case NGRSyntaxURL:
                [self validateSyntaxWithName:@"syntax: URL" block:^NGRError(NSString *string) {
                    return [string ngr_isURL] ? NGRErrorNoone : NGRErrorNotURL;
                }]; break;
                
            default:
                break;
        }
        
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSString *, NSRegularExpressionOptions))regex {
    return ^(NSString *pattern, NSRegularExpressionOptions options) {
        [self validateSyntaxWithName:@"regex" block:^NGRError(NSString *string) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
            NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
            return (matches == 1) ? NGRErrorNoone : NGRErrorWrongRegex;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgWrongRegex {
    return ^(NSString *message) {
        [self.messages setMessage:message forError:NGRErrorWrongRegex];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NGRSyntax, NSString *))msgWrongSyntax {
    return ^(NGRSyntax aSyntax, NSString *message) {
        [self.messages setMessage:message forError:[self errorFromSyntax:aSyntax]];
        return self;
    };
}

- (NGRError)errorFromSyntax:(NGRSyntax)syntax {
    switch (syntax) {
        case NGRSyntaxEmail:
            return NGRErrorNotEmail;
        case NGRSyntaxName:
            return NGRErrorNotName;
        case NGRSyntaxURL:
            return NGRErrorNotURL;
            
        default:
            return NGRErrorNoone;
    }
}

@end
