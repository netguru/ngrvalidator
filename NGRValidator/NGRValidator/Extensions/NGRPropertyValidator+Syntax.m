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

- (void)validateSyntaxWithBlock:(NGRSyntaxValidationBlock)validationBlock {
    [self validateClass:[NSString class] withBlock:^NGRError(NSString *value) {
        return validationBlock(value);
    }];
}

- (NGRPropertyValidator *(^)(NGRSyntax))syntax {
    return ^(NGRSyntax aSyntax) {
        
        switch (aSyntax) {
            case NGRSyntaxEmail:
                [self validateSyntaxWithBlock:^NGRError(NSString *string) {
                    return [string ngr_isEmail] ? NGRErrorNoone : NGRErrorNotEmail;
                }]; break;
                
            case NGRSyntaxName:
                [self validateSyntaxWithBlock:^NGRError(NSString *string) {
                    return [string ngr_isName] ? NGRErrorNoone : NGRErrorNotName;
                }]; break;
                
            case NGRSyntaxURL:
                [self validateSyntaxWithBlock:^NGRError(NSString *string) {
                    return [string ngr_isURL] ? NGRErrorNoone : NGRErrorNotURL;
                }]; break;
                
            default:
                break;
        }
        
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSRegularExpression *))regex {
    return ^(NSRegularExpression *aRegex) {
        [self validateSyntaxWithBlock:^NGRError(NSString *string) {
            NSUInteger matches = [aRegex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
            return (matches == 1) ? NGRErrorNoone : NGRErrorWrongRegex;
        }];
        return self;
    };
}

#pragma mark - Messaging

- (NGRPropertyValidator *(^)(NSString *))msgWrongRegex {
    return ^(NSString *message) {
        [self setMessage:message forError:NGRErrorWrongRegex];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NGRSyntax, NSString *))msgWrongSyntax {
    return ^(NGRSyntax aSyntax, NSString *message) {
        [self setMessage:message forError:[self errorFromSyntax:aSyntax]];
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
