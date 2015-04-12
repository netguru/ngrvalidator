//
//  NGRBehaviorKeys.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 13.02.2015.
//
//

@class NGRTestModel;

typedef NGRPropertyValidator * (^NGRPropertyValidatorBlock)(NGRPropertyValidator *validator);

// helpers:
extern NSString *const msg;
extern NSString *const NGRSKIP;
extern NSString *validatorDescriptor;
extern NSString *successDescriptor;
extern NSString *failureDescriptor;

// blocks:
extern NSDictionary * (^wrapDataWithScenario)(id value, NSString *scenario, NSInteger errorCount, NGRPropertyValidatorBlock block);
extern NSDictionary * (^wrapData)(id validValue, id invalidValue, NSInteger errorCount, NGRPropertyValidatorBlock block);
extern NSDictionary * (^wrapAssertData)(id value, NGRPropertyValidatorBlock block);
extern NSDictionary * (^wrapDataForMultipleProperties)(NGRTestModel *, NSArray *, BOOL);

extern void (^testDescriptor)(NSString *testDescription, NSString *successDescription, NSString *failureDescription);
extern void (^cleanDescriptors)(void);

// data keys:
extern NSString *const NGRValidatorKey;
extern NSString *const NGRValidValueKey;
extern NSString *const NGRInvalidValueKey;
extern NSString *const NGRErrorCountKey;
extern NSString *const NGRScenarioKey;

// behaviors:
extern NSString *const NGRValueBehavior;
extern NSString *const NGRAssertBehavior;
extern NSString *const NGRScenarioSuccessBehavior;
extern NSString *const NGRScenarioFailureBehavior;
extern NSString *const NGRMultiplePropertiesBehavior;
