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
    
    typedef void (^NGPropertyErrorBlock)(NSString *, NGRError, NGRPropertyValidator *);
    NGPropertyErrorBlock testMessage = ^(NSString *name, NGRError error, NGRPropertyValidator *validator) {
        
        describe([NSString stringWithFormat:@"should save custom message for %@ description", name], ^{
            
            it(@"using block", ^{
                [[[validator messageForError:error] should] equal:KBlockMessage];
            });
        });
    };
    
    NGRPropertyValidator *validator = [NGRPropertyValidator validatorForProperty:kPropertyName];
    testMessage(@"required", NGRErrorRequired, validator.msgNil(KBlockMessage));
});

SPEC_END
