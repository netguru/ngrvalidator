//
//  NGRBehaviorKeys.m
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
NSString *const NGRBehavior = @"using";

// helpers:
NSString *testDescriptor;
NSString *const msg = @"foo";

NSDictionary *(^wrapData)(id, id, NSInteger, NGRPropertyValidator *(^)(NGRPropertyValidator *)) = ^(id validValue, id invalidValue, NSInteger errorCount, NGRPropertyValidator *(^block)(NGRPropertyValidator *validator)) {
    
    return @{NGRValidatorKey : block(NGRValidate(@"value")),
             NGRValidValueKey : validValue,
             NGRInvalidValueKey : invalidValue,
             NGRErrorCountKey : @(errorCount)};
};