//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Kiwi.h>

#import "NGRPropertyValidator+NSString.h"
#import "NGRPropertyValidator+NSObject.h"
#import "NGRPropertyValidator+NSNumber.h"
#import "NGRPropertyValidator+Syntax.h"
#import "NGRPropertyValidator+NSDate.h"

#define kPropertyName @"bar"
#define KBlockMessage @"foo"

SPEC_BEGIN(NGRPropertyValidatorSpec)

describe(@"NGPropertyValidator", ^{
    
    __block NGRPropertyValidator *propertyValidator;
    
    beforeEach(^{
        propertyValidator = [NGRPropertyValidator validatorForProperty:kPropertyName];
    });
    
    specify(^{
        [[propertyValidator shouldNot] beNil];
    });
    
    it(@"should property name be equal to inited one", ^{
        [[theValue(propertyValidator.property) should] equal:theValue(kPropertyName)];
    });
    
    it(@"should have exactly 21 messages", ^{
        [[propertyValidator.messages should] haveCountOf:21];
    });
    
    typedef void (^NGPropertyErrorBlock)(NSString *, NGRError, NGRPropertyValidator *);
    NGPropertyErrorBlock testMessage = ^(NSString *name, NGRError error, NGRPropertyValidator *validator) {
        
        describe([NSString stringWithFormat:@"should save custom message for %@ error", name], ^{
            
            it(@"using block", ^{
                [[[validator messageForError:error] should] equal:KBlockMessage];
            });
        });
    };
    
    NGRPropertyValidator *validator = [NGRPropertyValidator validatorForProperty:kPropertyName];
    
    //NGRPropertyValidator + NSObject
    testMessage(@"required", NGRErrorRequired, validator.msgNil(KBlockMessage));
    
    //NGRPropertyValidator + NSString
    testMessage(@"not decimal", NGRErrorNotDecimal, validator.msgNotDecimal(KBlockMessage));
    testMessage(@"too short", NGRErrorTooShort, validator.msgTooShort(KBlockMessage));
    testMessage(@"too long", NGRErrorTooLong, validator.msgTooLong(KBlockMessage));
    testMessage(@"not exact length", NGRErrorNotExactLength, validator.msgNotExactLength(KBlockMessage));
    testMessage(@"doesnt match", NGRErrorNotMatch, validator.msgNotMatch(KBlockMessage));
    
    //NGRPropertyValidator + NSNumber
    testMessage(@"isnt false", NGRErrorNotTrue, validator.msgNotTrue(KBlockMessage));
    testMessage(@"isnt true", NGRErrorNotFalse, validator.msgNotFalse(KBlockMessage));
    testMessage(@"too small", NGRErrorTooSmall, validator.msgTooSmall(KBlockMessage));
    testMessage(@"too big", NGRErrorTooBig, validator.msgTooBig(KBlockMessage));
    testMessage(@"not exact", NGRErrorNotExact, validator.msgNotExact(KBlockMessage));
    
    //NGRPropertyValidator + Syntax
    testMessage(@"email syntax", NGRErrorNotEmail, validator.msgWrongSyntax(NGRSyntaxEmail, KBlockMessage));
    testMessage(@"name syntax", NGRErrorNotName, validator.msgWrongSyntax(NGRSyntaxName, KBlockMessage));
    testMessage(@"url syntax", NGRErrorNotURL, validator.msgWrongSyntax(NGRSyntaxURL, KBlockMessage));
    testMessage(@"wrong regex", NGRErrorWrongRegex, validator.msgWrongRegex(KBlockMessage));
    
    //NGRPropertyValidator + NSDate
    testMessage(@"not later than", NGRErrorNotLaterThan, validator.msgNotLaterThan(KBlockMessage));
    testMessage(@"not later than or equal to", NGRErrorNotLaterThanOrEqualTo, validator.msgNotLaterThanOrEqualTo(KBlockMessage));
    testMessage(@"not earlier than", NGRErrorNotEarlierThan, validator.msgNotEarlierThan(KBlockMessage));
    testMessage(@"not earlier than or equal to", NGRErrorNotLaterThanOrEqualTo, validator.msgNotEarlierThanOrEqualTo(KBlockMessage));
    testMessage(@"not between dates", NGRErrorNotBetweenDates, validator.msgNotBetweenDates(KBlockMessage));
    
    //
    [validator setMessage:KBlockMessage forError:NGRErrorCustomCondition];
    [validator setMessage:KBlockMessage forError:NGRErrorNoone];
    [validator setMessage:KBlockMessage forError:NGRErrorUnexpectedClass];
    
    it(@"all messages should be custom", ^{
        NSArray *keys = [validator messages].allKeys;
        for(NSString *key in keys) {
            [[[validator messages][key] should] equal:KBlockMessage];
        }
    });
});

SPEC_END
