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

@implementation NGRValidationTestModel @end

#define kValue @"value"
#define kName @"name"
#define kErrorsNumber @"errorsNumber"
#define kExpectedClass @"expectedClass"
#define kErrorMessage @"baz"
#define kScenario @"scenario"
#define kValidScenario @"validScenario"

#define kFirstScenario @"firstScenario"
#define kSecondScenario @"secondScenario"

SPEC_BEGIN(NGRValidatorSpec)


describe(@"NGRValidator", ^{
    
    typedef void (^NGRTestResultBlock)(NSArray *, BOOL , NSError *, NSError *, NSNumber *, BOOL);
    NGRTestResultBlock testResultBlock = ^(NSArray *array, BOOL success, NSError *error_1, NSError *error_2, NSNumber *errorNumbers, BOOL isValid) {
        
        if (isValid) {
            [[theValue(success) should] beYes];
            [[array should] beNil];
            [[error_1 should] beNil];
            [[error_2 should] beNil];
        } else {
            [[theValue(success) should] beNo];
            [[array should] haveCountOf:[errorNumbers integerValue]];
            [[error_1 shouldNot] beNil];
            [[error_1.localizedDescription should] containString:kErrorMessage];
            [[error_2 shouldNot] beNil];
            [[error_2.localizedDescription should] containString:kErrorMessage];
        }
    };
    
    typedef NSDictionary * (^NGValidationRuleBlock)(NSString *, NSObject *, NSUInteger, Class, NSString *, NSNumber *);
    NGValidationRuleBlock rule = ^(NSString *name, NSObject * value, NSUInteger errors, Class expectedClass, NSObject *scenario, NSNumber *validScenario) {
        NSMutableDictionary *dictionary = [@{kValue : value, kName : name, kErrorsNumber : @(errors), kExpectedClass : expectedClass} mutableCopy];
        if (scenario) dictionary[kScenario] = scenario;
        if (validScenario) dictionary[kValidScenario] = validScenario;
        return [dictionary copy];
    };
    
    typedef void (^NGValidationTestBlock)(NSString *, NSArray *(^)(), void(^)(NGRPropertyValidator *));
    NGValidationTestBlock test = ^(NSString *name, NSArray *(^rules)(), void(^configureBlock)(NGRPropertyValidator *)) {
        
        describe([NSString stringWithFormat:@"%@ validator", name], ^{
            
            __block NGRPropertyValidator *propertyValidator = nil;
            __block NGRValidationTestModel *model = nil;
            
            beforeEach(^{
                model = [[NGRValidationTestModel alloc] init];
                propertyValidator = [NGRPropertyValidator validatorForProperty:kValue];
            });
            
            specify(^{
                [[propertyValidator shouldNot] beNil];
            });
            
            for (NSDictionary *rule in rules()) {
                
                context([NSString stringWithFormat:@"using %@", rule[kName]], ^{
                    
                    __block BOOL success; __block  NSError *error_1; __block  NSError *error_2; __block NSArray *array;
                    
                    beforeEach(^{
                        configureBlock(propertyValidator);
                        model.value = rule[kValue];
                        success = NO; error_1 = nil; error_2 = nil; array = nil;
                    });
                    
                    NSArray *(^rulesBlock)() = ^NSArray *{
                        return @[propertyValidator];
                    };
                    
                    if(![rule[kValue] isKindOfClass:rule[kExpectedClass]]) {
                        
                        it(@"should not accept class other than allowed", ^{
                            [[theBlock(^{
                                [NGRValidator validateModel:model error:&error_1 usingRules:rulesBlock];
                            }) should] raiseWithName:NSInternalInconsistencyException];
                            
                            [[theBlock(^{
                                [NGRValidator validateModel:model usingRules:rulesBlock];
                            }) should] raiseWithName:NSInternalInconsistencyException];
                            
                            [[theBlock(^{
                                [NGRValidator validateValue:rule[kValue] named:rule[kName] usingRules:^(NGRPropertyValidator *validator) {
                                    configureBlock(validator);
                                }];
                            }) should] raiseWithName:NSInternalInconsistencyException];
                        });
                        
                    } else if (rule[kScenario]) {
                        
                        if ([rule[kValidScenario] isEqualToNumber:@YES]) {
                            
                            if ([rule[kErrorsNumber] isEqualToNumber:@0]) {
                                
                                it(@"should succeed", ^{
                                    success = [NGRValidator validateModel:model error:&error_1 scenario:rule[kScenario] usingRules:rulesBlock];
                                    array = [NGRValidator validateModel:model scenario:rule[kScenario] usingRules:rulesBlock];
                                    testResultBlock(array, success, error_1, error_2, rule[kErrorsNumber], YES);
                                });
                                
                            } else {
                                
                                it(@"should fail", ^{
                                    success = [NGRValidator validateModel:model error:&error_1 scenario:rule[kScenario] usingRules:rulesBlock];
                                    array = [NGRValidator validateModel:model scenario:rule[kScenario] usingRules:rulesBlock];
                                    //simulate error:
                                    error_2 = [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey : kErrorMessage}];
                                    testResultBlock(array, success, error_1, error_2, rule[kErrorsNumber], NO);
                                });
                            }
                            
                        } else {
                            
                            it(@"should succeed", ^{
                                success = [NGRValidator validateModel:model error:&error_1 scenario:rule[kScenario] usingRules:rulesBlock];
                                array = [NGRValidator validateModel:model scenario:rule[kScenario] usingRules:rulesBlock];
                                testResultBlock(array, success, error_1, error_2, rule[kErrorsNumber], YES);
                            });
                        }

                    } else if ([rule[kErrorsNumber] isEqualToNumber:@0]) {
                        
                        it(@"should succeed", ^{
                            
                            success = [NGRValidator validateModel:model error:&error_1 usingRules:rulesBlock];
                            array = [NGRValidator validateModel:model usingRules:rulesBlock];
                            error_2 = [NGRValidator validateValue:rule[kValue] named:rule[kName] usingRules:^(NGRPropertyValidator *validator) {
                                configureBlock(validator);
                            }];
                            testResultBlock(array, success, error_1, error_2, rule[kErrorsNumber], YES);
                        });
                        
                    } else {
                        
                        it(@"should fail", ^{
                            success = [NGRValidator validateModel:model error:&error_1 usingRules:rulesBlock];
                            array = [NGRValidator validateModel:model usingRules:rulesBlock];
                            error_2 = [NGRValidator validateValue:rule[kValue] named:rule[kName] usingRules:^(NGRPropertyValidator *validator) {
                                configureBlock(validator);
                            }];
                            
                            testResultBlock(array, success, error_1, error_2, rule[kErrorsNumber], NO);
                        });
                    }
                });
            }
        });
    };
    
    /******************************************************************************
     *                                Scenarios                                   *
     ******************************************************************************/
    test(@"decimal on 1 scenario", ^() {
        return @[rule(@"non-decimal string on other scenario", @"foo_bar_baz", 0, [NSString class], kSecondScenario, @NO),
                 rule(@"correct decimal string on other scenario", @"123", 0, [NSString class], kSecondScenario, @NO),
                 rule(@"non-decimal string on correct scenario", @"foo_bar_baz", 1, [NSString class], kFirstScenario, @YES),
                 rule(@"correct decimal string on correct scenario", @"123", 0, [NSString class], kFirstScenario, @YES)];
    }, ^(NGRPropertyValidator *validator) {
        validator.decimal().msgNotDecimal(kErrorMessage).onScenarios(@[kFirstScenario]);
    });
    
    test(@"decimal on 2 scenario", ^() {
        return @[rule(@"non-decimal string on second scenario", @"foo_bar_baz", 1, [NSString class], kSecondScenario, @YES),
                 rule(@"correct decimal string on second scenario", @"123", 0, [NSString class], kSecondScenario, @YES),
                 rule(@"non-decimal string on first scenario", @"foo_bar_baz", 1, [NSString class], kFirstScenario, @YES),
                 rule(@"correct decimal string on first scenario", @"123", 0, [NSString class], kFirstScenario, @YES)];
    }, ^(NGRPropertyValidator *validator) {
        validator.decimal().msgNotDecimal(kErrorMessage).onScenarios(@[kFirstScenario, kSecondScenario]);
    });
    
    /******************************************************************************
     *                               Exceptions                                   *
     ******************************************************************************/
    test(@"any string", ^() {
        return @[rule(@"incorrect defined class", @123, 1, [NSString class], nil, nil),
                 rule(@"correct defined class", @"123", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.decimal().msgNotDecimal(kErrorMessage);
    });
    
    /******************************************************************************
     *                            Multiple errors                                 *
     ******************************************************************************/
    test(@"maxLength and decimal", ^() {
        return @[rule(@"to long non-decimal string", @"foo_bar_baz", 2, [NSString class], nil, nil),
                 rule(@"decimal with required length", @"123", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().maxLength(5).decimal().msgNotDecimal(kErrorMessage).msgTooLong(kErrorMessage);
    });
    
    /******************************************************************************
     *                               Objects                                      *
     ******************************************************************************/
    test(@"required", ^() {
        return @[rule(@"no value", [NSNull null], 1, [NSNull class], nil, nil),
                 rule(@"any value", @"foo", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().msgNil(kErrorMessage);
    });
    
    test(@"dontAllowEmpty", ^() {
        return @[rule(@"nil", [NSNull null], 1, [NSNull class], nil, nil),
                 rule(@"empty string", @"", 1, [NSString class], nil, nil),
                 rule(@"any string", @"foo", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().msgNil(kErrorMessage);
    });
    
    test(@"allowEmpty", ^() {
        return @[rule(@"nil", [NSNull null], 1, [NSNull class], nil, nil),
                 rule(@"empty string", @"", 0, [NSString class], nil, nil),
                 rule(@"any string", @"foo", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().allowEmpty().msgNil(kErrorMessage);
    });
    
    test(@"allowEmpty with other rules", ^() {
        return @[rule(@"any string", @"foo", 1, [NSString class], nil, nil),
                 rule(@"empty string", @"", 1, [NSString class], nil, nil),
                 rule(@"any string", @"foo_bar_baz", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().allowEmpty().minLength(4).msgNil(kErrorMessage).msgTooShort(kErrorMessage);
    });
    
    /******************************************************************************
     *                               Strings                                      *
     ******************************************************************************/
    
    test(@"decimal", ^() {
        return @[rule(@"invalid decimal", @"123ewq", 1, [NSString class], nil, nil),
                 rule(@"valid decimal", @"123567", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().decimal().msgNotDecimal(kErrorMessage);
    });

    
    test(@"minLength", ^() {
        return @[rule(@"too short string", @"foo", 1, [NSString class], nil, nil),
                 rule(@"string with required length", @"foo_bar_baz", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().minLength(5).msgTooShort(kErrorMessage);
    });
    
    test(@"maxLength", ^() {
        return @[rule(@"too long string", @"foo_bar_baz", 1, [NSString class], nil, nil),
                 rule(@"string with required length", @"foo", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().maxLength(5).msgTooLong(kErrorMessage);
    });
    
    test(@"exactLength", ^() {
        return @[rule(@"too long string", @"foo_bar", 1, [NSString class], nil, nil),
                 rule(@"too short string", @"foo", 1, [NSString class], nil, nil),
                 rule(@"string with correct length", @"_foo_", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().exactLength(5).msgNotExactLength(kErrorMessage);
    });
    
    test(@"lengthRange", ^() {
        return @[rule(@"too long string", @"foo_bar", 1, [NSString class], nil, nil),
                 rule(@"too short string", @"f", 1, [NSString class], nil, nil),
                 rule(@"string with required length", @"foo", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().lengthRange(2, 4).msgTooShort(kErrorMessage).msgTooLong(kErrorMessage);
    });
    
    test(@"match", ^() {
        return @[rule(@"different string", @"bar", 1, [NSString class], nil, nil),
                 rule(@"same string", @"foo", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().match(@"foo").msgNotMatch(kErrorMessage);
    });
    
    test(@"differ", ^() {
        return @[rule(@"same string", @"foo", 1, [NSString class], nil, nil),
                 rule(@"different string", @"bar", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().differ(@"foo").msgNotDiffer(kErrorMessage);
    });
    
    /******************************************************************************
     *                                Numbers                                     *
     ******************************************************************************/
    
    test(@"min", ^() {
        return @[rule(@"too small number", @1.23f, 1, [NSNumber class], nil, nil),
                 rule(@"exact number", @100.23f, 0, [NSNumber class], nil, nil),
                 rule(@"bigger number", @101.23f, 0, [NSNumber class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().min(100.23f).msgTooSmall(kErrorMessage);
    });
    
    test(@"max", ^() {
        return @[rule(@"too large number", @101.23f, 1, [NSNumber class], nil, nil),
                 rule(@"exact number", @100.23f, 0, [NSNumber class], nil, nil),
                 rule(@"smaller number", @1.23f, 0, [NSNumber class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().max(100.23f).msgTooBig(kErrorMessage);
    });
    
    test(@"exact", ^() {
        return @[rule(@"too big number", @101.23f, 1, [NSNumber class], nil, nil),
                 rule(@"too small number", @1.23f, 1, [NSNumber class], nil, nil),
                 rule(@"expected number", @100.23f, 0, [NSNumber class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().exact(100.23f).msgNotExact(kErrorMessage);
    });
    
    test(@"range", ^() {
        return @[rule(@"to big number", @200.23f, 1, [NSNumber class], nil, nil),
                 rule(@"to small number", @1.23f, 1, [NSNumber class], nil, nil),
                 rule(@"expected number", @100.23f, 0, [NSNumber class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().range(50.23f, 150.23f).msgTooBig(kErrorMessage).msgTooSmall(kErrorMessage);
    });
    
    test(@"falseValue", ^() {
        return @[rule(@"true", @YES, 1, [NSNumber class], nil, nil),
                 rule(@"false", @NO, 0, [NSNumber class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().falseValue().msgNotFalse(kErrorMessage);
    });
    
    test(@"trueValue", ^() {
        return @[rule(@"false", @NO, 1, [NSNumber class], nil, nil),
                 rule(@"true", @YES, 0, [NSNumber class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().trueValue().msgNotTrue(kErrorMessage);
    });
    
    /******************************************************************************
     *                                 Syntax                                     *
     ******************************************************************************/
    
    test(@"syntax Email", ^() {
        return @[rule(@"wrong email syntax", @"email@.", 1, [NSString class], nil, nil),
                 rule(@"valid email syntax", @"email@example.com", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().syntax(NGRSyntaxEmail).msgWrongSyntax(NGRSyntaxEmail, kErrorMessage);
    });
    
    test(@"regex", ^() {
        return @[rule(@"wrong regex syntax", @"b4z", 1, [NSString class], nil, nil),
                 rule(@"valid regex syntax", @"QUX", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().regex(@"q.*", NSRegularExpressionCaseInsensitive).msgWrongRegex(kErrorMessage);
    });
    
    test(@"syntax URL", ^() {
        return @[rule(@"wrong url syntax", @"http://bar", 1, [NSString class], nil, nil),
                 rule(@"valid url syntax", @"http://www.google.com", 0, [NSString class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().syntax(NGRSyntaxURL).msgWrongSyntax(NGRSyntaxURL, kErrorMessage);
    });
    
    /******************************************************************************
     *                                  Dates                                     *
     ******************************************************************************/
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:10];
    
    test(@"earlierThan", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class], nil, nil),
                 rule(@"2 correct dates", date1, 0, [NSDate class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().earlierThan(date2).msgNotEarlierThan(kErrorMessage);
    });
    
    test(@"laterThan", ^() {
        return @[rule(@"2 incorrect dates", date1, 1, [NSDate class], nil, nil),
                 rule(@"2 correct dates", date2, 0, [NSDate class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().laterThan(date1).msgNotLaterThan(kErrorMessage);
    });
    
    test(@"earlierThanOrEqualTo", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class], nil, nil),
                 rule(@"2 correct dates", date1, 0, [NSDate class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().earlierThanOrEqualTo(date1).msgNotEarlierThanOrEqualTo(kErrorMessage);
    });
    
    test(@"laterThanOrEqualTo", ^() {
        return @[rule(@"2 incorrect dates", date1, 1, [NSDate class], nil, nil),
                 rule(@"2 correct dates", date2, 0, [NSDate class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().laterThanOrEqualTo(date2).msgNotLaterThanOrEqualTo(kErrorMessage);
    });
    
    test(@"betweenDates inclusive", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class], nil, nil),
                 rule(@"2 correct dates", date1, 0, [NSDate class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().betweenDates([NSDate dateWithTimeIntervalSinceNow:-10], date1, YES).msgNotBetweenDates(kErrorMessage);
    });
    
    test(@"betweenDates exclusive", ^() {
        return @[rule(@"2 incorrect dates", date2, 1, [NSDate class], nil, nil),
                 rule(@"2 correct dates", date1, 0, [NSDate class], nil, nil)];
    }, ^(NGRPropertyValidator *validator) {
        validator.required().betweenDates([NSDate dateWithTimeIntervalSinceNow:-10], date2, NO).msgNotBetweenDates(kErrorMessage);
    });
});

SPEC_END

