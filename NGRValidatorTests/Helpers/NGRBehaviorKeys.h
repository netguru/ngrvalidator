//
//  NGRBehaviorKeys.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 13.02.2015.
//
//


// helpers:
extern NSString *const msg;
extern NSString *validatorDescriptor;
extern NSString *successDescriptor;
extern NSString *failureDescriptor;

// blocks:
extern NSDictionary * (^wrapData)(id validValue, id invalidValue, NSInteger errorCount, NGRPropertyValidator *(^)(NGRPropertyValidator *validator));
extern NSDictionary * (^wrapAssertData)(id value, NGRPropertyValidator *(^)(NGRPropertyValidator *validator));
extern void (^testDescriptor)(NSString *testDescription, NSString *successDescription, NSString *failureDescription);
extern void (^cleanDescriptors)(void);

// data keys:
extern NSString *const NGRValidatorKey;
extern NSString *const NGRValidValueKey;
extern NSString *const NGRInvalidValueKey;
extern NSString *const NGRErrorCountKey;

// behaviors:
extern NSString *const NGRValueBehavior;
extern NSString *const NGRAssertBehavior;
