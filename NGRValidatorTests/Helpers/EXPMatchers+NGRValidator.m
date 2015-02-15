//
//  EXPMatchers+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 15.02.2015.
//
//
//

#import "EXPMatchers+NGRValidator.h"

typedef void (^NGRAttributeBlock) (NSString *, NSInteger);

static NSInteger realOccurrence;
static NSInteger expectedOccurrence;
static NSString *ruleName;

EXPMatcherImplementationBegin(ngr_hasMessagesSet, (NSDictionary *messages)) {
    
    BOOL actualIsValidationRule = [actual isKindOfClass:[NGRValidationRule class]];
    NGRValidationRule *rule = (NGRValidationRule *)actual;
    
    prerequisite(^BOOL {
        return actualIsValidationRule;
    });
    
    match(^BOOL {
        
        NGRError error;
        
        if ([rule.name isEqualToString:@"decimal"]) {
            ruleName = @"decimal"; error = NGRErrorNotDecimal;
        }
        
        return [messages[@(error)] containsString:msg];
        
//        realOccurrence = 0;
//        [propertyValidator.validationRules enumerateObjectsUsingBlock:^(NGRValidationRule *rule, NSUInteger idx, BOOL *stop) {
//            for (NSString *message in propertyValidator.messages.allValues) {
//                if ([message containsString:msg]) {
//                    realOccurrence++;
//                }
//            }
//        }];
//        expectedOccurrence = [messagesCount integerValue];
//        return realOccurrence == expectedOccurrence;
    });
    
    failureMessageForTo(^NSString * {
        NSString *expectedDescription = @"", *actualDescription = @"";
        
        if (!actualIsValidationRule) {
            expectedDescription = [NSString stringWithFormat:@"an instance of %@", [NGRValidationRule class]];
            actualDescription = [NSString stringWithFormat:@"an instance of %@", [actual class]];
            
            return [NSString stringWithFormat:@"expected: %@, got: %@", expectedDescription, actualDescription];
        } else {
            return [NSString stringWithFormat:@"expected message occurrence in %@ rule: %ld, got: %ld", ruleName, (long)expectedOccurrence, (long)realOccurrence];
        }
    });
    
    failureMessageForNotTo(^NSString * {
        NSString *expectedDescription = @"", *actualDescription = @"";
        
        if (!actualIsValidationRule) {
            expectedDescription = [NSString stringWithFormat:@"an instance of %@", [NGRValidationRule class]];
            actualDescription = [NSString stringWithFormat:@"an instance of %@", [actual class]];
            
            return [NSString stringWithFormat:@"expected: %@, got: %@", expectedDescription, actualDescription];
        } else {
            return [NSString stringWithFormat:@"expected message occurrence in %@ rule: %ld, got: %ld", ruleName, (long)expectedOccurrence, (long)realOccurrence];
        }
    });
    
} EXPMatcherImplementationEnd
