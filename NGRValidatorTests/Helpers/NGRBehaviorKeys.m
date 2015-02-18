//
//  NGRValueBehaviorKeys.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 13.02.2015.
//
//


// data keys:
NSString *const NGRValidatorKey = @"NGRValidatorKey";
NSString *const NGRValidValueKey = @"NGRValidValue";
NSString *const NGRInvalidValueKey = @"NGRInvalidValue";
NSString *const NGRErrorCountKey = @"NGRErrorCountKey";
NSString *const NGRScenarioKey = @"NGRScenarioKey";

// behaviors:
NSString *const NGRValueBehavior = @"using";
NSString *const NGRAssertBehavior = @"Assertion test";
NSString *const NGRScenarioSuccessBehavior = @"success behavior";
NSString *const NGRScenarioFailureBehavior = @"failure behavior";

// helpers:
NSString *validatorDescriptor;
NSString *successDescriptor;
NSString *failureDescriptor;
NSString *const msg = @"foo";

NSDictionary * (^wrapData)(id, id, NSInteger, NGRPropertyValidatorBlock) = ^(id validValue, id invalidValue, NSInteger errorCount, NGRPropertyValidatorBlock block) {
    
    NSMutableDictionary *dictionary = [@{NGRValidatorKey : block(NGRValidate(@"value")),
                                         NGRErrorCountKey : @(errorCount)} mutableCopy];
    
    if (validValue) {
        dictionary[NGRValidValueKey] = validValue;
    }
    if (invalidValue){
        dictionary[NGRInvalidValueKey] = invalidValue;
    }
    return [dictionary copy];
};

NSDictionary * (^wrapDataWithScenario)(id, NSString *, NSInteger, NGRPropertyValidatorBlock) = ^(id value, NSString *scenario, NSInteger errorCount, NGRPropertyValidatorBlock block) {

    return @{NGRValidatorKey : block(NGRValidate(@"value")),
             NGRErrorCountKey : @(errorCount),
             NGRScenarioKey : scenario,
             NGRValidValueKey : value};
};

NSDictionary * (^wrapAssertData)(id, NGRPropertyValidatorBlock) = ^(id value, NGRPropertyValidatorBlock block) {
    
    return @{NGRValidatorKey : block(NGRValidate(@"value")),
             NGRValidValueKey : value};
};

void (^testDescriptor)(NSString *, NSString *, NSString *) = ^(NSString *validatorDescription, NSString *successDescription, NSString *failureDescription) {
    validatorDescriptor = validatorDescription;
    successDescriptor = successDescription;
    failureDescriptor = failureDescription;
};

void (^cleanDescriptors)(void) = ^(void) {
    validatorDescriptor = nil; successDescriptor = nil; failureDescriptor = nil;
};
