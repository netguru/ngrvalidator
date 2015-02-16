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

// behaviors:
NSString *const NGRValueBehavior = @"using";
NSString *const NGRAssertBehavior = @"Assertion test";

// helpers:
NSString *validatorDescriptor;
NSString *successDescriptor;
NSString *failureDescriptor;
NSString *const msg = @"foo";

NSDictionary * (^wrapData)(id, id, NSInteger, NGRPropertyValidator *(^)(NGRPropertyValidator *)) = ^(id validValue, id invalidValue, NSInteger errorCount, NGRPropertyValidator *(^block)(NGRPropertyValidator *validator)) {
    
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

NSDictionary * (^wrapAssertData)(id, NGRPropertyValidator *(^)(NGRPropertyValidator *)) = ^(id value, NGRPropertyValidator *(^block)(NGRPropertyValidator *validator)) {
    
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
