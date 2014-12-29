//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 22.12.2014.
//
//

#import "NGRValidator.h"
#import <Kiwi.h>

@interface NGRValidationTestModel : NSObject
@property (unsafe_unretained, nonatomic) id value;
@end

#define kValue @"value"
#define kName @"name"
#define kErrorsNumber @"errorsNumber"
#define kExpectedClass @"expectedClass"
#define kErrorMessage @"baz"

SPEC_BEGIN(NGRValidatorSpec)


describe(@"NGRValidator", ^{
    
    typedef NSDictionary * (^NGValidationRuleBlock)(NSString *, NSObject *, NSUInteger, Class);
    NGValidationRuleBlock rule = ^(NSString *name, NSObject * value, NSUInteger errors, Class expectedClass) {
        return @{kValue : value, kName : name, kErrorsNumber : @(errors), kExpectedClass : expectedClass};
    };
    
    typedef void (^NGValidationTestBlock)(NSString *, NSArray *(^)(), void(^)(NGRPropertyValidator *));
    NGValidationTestBlock test = ^(NSString *name, NSArray *(^rules)(), void(^configureBlock)(NGRPropertyValidator *)) {
        
        describe([NSString stringWithFormat:@"%@ validator", name], ^{
            
            __block NGRPropertyValidator *validator = nil;
            __block NGRValidationTestModel *model = nil;
            
            beforeEach(^{
                model = [[NGRValidationTestModel alloc] init];
                validator = [NGRPropertyValidator validatorForProperty:kValue];
            });
            
            specify(^{
                [[validator shouldNot] beNil];
            });
            
            for (NSDictionary *rule in rules()) {
                
                context([NSString stringWithFormat:@"using %@", rule[kName]], ^{
                    
                    __block BOOL success; __block  NSError *error; __block NSArray *array;
                    
                    beforeEach(^{
                        configureBlock(validator);
                        model.value = rule[kValue];
                        success = NO; error = nil; array = nil;
                    });
                    
                    NSArray *(^rulesBlock)() = ^NSArray *{
                        return @[validator];
                    };
                    
                    if(![rule[kValue] isKindOfClass:rule[kExpectedClass]]) {
                        
                        it(@"should not accept class other than allowed", ^{
                            [[theBlock(^{
                                [NGRValidator validateModel:model error:&error usingRules:rulesBlock];
                            }) should] raiseWithName:NSInternalInconsistencyException];
                            
                            [[theBlock(^{
                                [NGRValidator validateModel:model usingRules:rulesBlock];
                            }) should] raiseWithName:NSInternalInconsistencyException];
                        });
                        
                    } else if ([rule[kErrorsNumber] isEqualToNumber:@0]) {
                        
                        it(@"should succeed", ^{
                            success = [NGRValidator validateModel:model error:&error usingRules:rulesBlock];
                            array = [NGRValidator validateModel:model usingRules:rulesBlock];
                            
                            [[theValue(success) should] beYes];
                            [[error should] beNil];
                            [[array should] haveCountOf:[rule[kErrorsNumber] integerValue]];
                        });
                        
                    } else {
                        
                        it(@"should fail", ^{
                            
                            success = [NGRValidator validateModel:model error:&error usingRules:rulesBlock];
                            array = [NGRValidator validateModel:model usingRules:rulesBlock];
                            
                            [[theValue(success) should] beNo];
                            [[error shouldNot] beNil];
                            [[array should] haveCountOf:[rule[kErrorsNumber] integerValue]];
                            [[error.localizedDescription should] containString:kErrorMessage];
                        });
                    }
                });
            }
        });
    };
    
    /******************************************************************************
     *                               Exceptions                                   *
     ******************************************************************************/
    test(@"any string", ^() {
        return @[rule(@"incorrect defined class", @123, 1, [NSString class]),
                 rule(@"correct defined class", @"123", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.decimal().msgNotDecimal(kErrorMessage);
    });
    
    /******************************************************************************
     *                            Multiple errors                                 *
     ******************************************************************************/
    test(@"maxLength and decimal", ^() {
        return @[rule(@"to long non-decimal string", @"foo_bar_baz", 2, [NSString class]),
                 rule(@"decimal with required length", @"123", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().maxLength(5).decimal().msgNotDecimal(kErrorMessage).msgTooLong(kErrorMessage);
    });
    
    /******************************************************************************
     *                               Objects                                      *
     ******************************************************************************/
    test(@"required", ^() {
        return @[rule(@"no value", [NSNull null], 1, [NSNull class]),
                 rule(@"any value", @"foo", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().msgNil(kErrorMessage);
    });
    
    /******************************************************************************
     *                               Strings                                      *
     ******************************************************************************/
    
    test(@"decimal", ^() {
        return @[rule(@"invalid decimal", @"123ewq", 1, [NSString class]),
                 rule(@"valid decimal", @"123567", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().decimal().msgNotDecimal(kErrorMessage);
    });
    
    test(@"minLength", ^() {
        return @[rule(@"too short string", @"foo", 1, [NSString class]),
                 rule(@"string with required length", @"foo_bar_baz", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().minLength(5).msgTooShort(kErrorMessage);
    });
    
    test(@"maxLength", ^() {
        return @[rule(@"too long string", @"foo_bar_baz", 1, [NSString class]),
                 rule(@"string with required length", @"foo", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().maxLength(5).msgTooLong(kErrorMessage);
    });
    
    test(@"exactLength", ^() {
        return @[rule(@"too long string", @"foo_bar", 1, [NSString class]),
                 rule(@"too short string", @"foo", 1, [NSString class]),
                 rule(@"string with correct length", @"_foo_", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().exactLength(5).msgNotExactLength(kErrorMessage);
    });
    
    test(@"lengthRange", ^() {
        return @[rule(@"too long string", @"foo_bar", 1, [NSString class]),
                 rule(@"too short string", @"f", 1, [NSString class]),
                 rule(@"string with required length", @"foo", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().lengthRange(2, 4).msgTooShort(kErrorMessage).msgTooLong(kErrorMessage);
    });
    
    /******************************************************************************
     *                                Numbers                                     *
     ******************************************************************************/
    
    test(@"min", ^() {
        return @[rule(@"too small number", @1.23f, 1, [NSNumber class]),
                 rule(@"exact number", @100.23f, 0, [NSNumber class]),
                 rule(@"bigger number", @101.23f, 0, [NSNumber class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().min(100.23f).msgTooSmall(kErrorMessage);
    });
    
    test(@"max", ^() {
        return @[rule(@"too large number", @101.23f, 1, [NSNumber class]),
                 rule(@"exact number", @100.23f, 0, [NSNumber class]),
                 rule(@"smaller number", @1.23f, 0, [NSNumber class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().max(100.23f).msgTooBig(kErrorMessage);
    });
    
    test(@"exact", ^() {
        return @[rule(@"too big number", @101.23f, 1, [NSNumber class]),
                 rule(@"too small number", @1.23f, 1, [NSNumber class]),
                 rule(@"expected number", @100.23f, 0, [NSNumber class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().exact(100.23f).msgNotExact(kErrorMessage);
    });
    
    test(@"range", ^() {
        return @[rule(@"to big number", @200.23f, 1, [NSNumber class]),
                 rule(@"to small number", @1.23f, 1, [NSNumber class]),
                 rule(@"expected number", @100.23f, 0, [NSNumber class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().range(50.23f, 150.23f).msgTooBig(kErrorMessage).msgTooSmall(kErrorMessage);
    });
    
    test(@"falseValue", ^() {
        return @[rule(@"true", @YES, 1, [NSNumber class]),
                 rule(@"false", @NO, 0, [NSNumber class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().falseValue().msgNotFalse(kErrorMessage);
    });
    
    test(@"trueValue", ^() {
        return @[rule(@"false", @NO, 1, [NSNumber class]),
                 rule(@"true", @YES, 0, [NSNumber class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().trueValue().msgNotTrue(kErrorMessage);
    });
    
    /******************************************************************************
     *                                 Syntax                                     *
     ******************************************************************************/
    
    test(@"syntax Email", ^() {
        return @[rule(@"wrong email syntax", @"email@.", 1, [NSString class]),
                 rule(@"valid email syntax", @"email@example.com", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().syntax(NGRSyntaxEmail).msgWrongSyntax(NGRSyntaxEmail, kErrorMessage);
    });
    
    test(@"regex", ^() {
        return @[rule(@"wrong regex syntax", @"foo", 1, [NSString class]),
                 rule(@"valid regex syntax", @"bar", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        NSString *pattern = @"b[a-z]";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
        validator.required().regex(regex).msgWrongRegex(kErrorMessage);
    });
    
    test(@"syntax URL", ^() {
        return @[rule(@"wrong url syntax", @"http://bar", 1, [NSString class]),
                 rule(@"valid url syntax", @"http://www.google.com", 0, [NSString class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().syntax(NGRSyntaxURL).msgWrongSyntax(NGRSyntaxURL, kErrorMessage);
    });
    
    /******************************************************************************
     *                                  Dates                                     *
     ******************************************************************************/
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:10];
    
    test(@"earlierThan", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class]),
                 rule(@"2 correct dates", date1, 0, [NSDate class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().earlierThan(date2).msgNotEarlierThan(kErrorMessage);
    });
    
    test(@"laterThan", ^() {
        return @[rule(@"2 incorrect dates", date1, 1, [NSDate class]),
                 rule(@"2 correct dates", date2, 0, [NSDate class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().laterThan(date1).msgNotLaterThan(kErrorMessage);
    });
    
    test(@"earlierThanOrEqualTo", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class]),
                 rule(@"2 correct dates", date1, 0, [NSDate class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().earlierThanOrEqualTo(date1).msgNotEarlierThanOrEqualTo(kErrorMessage);
    });
    
    test(@"laterThanOrEqualTo", ^() {
        return @[rule(@"2 incorrect dates", date1, 1, [NSDate class]),
                 rule(@"2 correct dates", date2, 0, [NSDate class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().laterThanOrEqualTo(date2).msgNotLaterThanOrEqualTo(kErrorMessage);
    });
    
    test(@"betweenDates inclusive", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class]),
                 rule(@"2 correct dates", date1, 0, [NSDate class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().betweenDates([NSDate dateWithTimeIntervalSinceNow:-10], date1, YES).msgNotBetweenDates(kErrorMessage);
    });
    
    test(@"betweenDates exclusive", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class]),
                 rule(@"2 correct dates", date1, 0, [NSDate class])];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().betweenDates([NSDate dateWithTimeIntervalSinceNow:-10], date2, NO).msgNotBetweenDates(kErrorMessage);
    });
});

SPEC_END

