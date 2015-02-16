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
extern void (^testDescriptor)(NSString *, NSString *, NSString *);
extern void (^cleanTestDescriptor)(void);

// data keys:
extern NSString *const NGRValidatorKey;
extern NSString *const NGRValidValueKey;
extern NSString *const NGRInvalidValueKey;
extern NSString *const NGRErrorCountKey;

// behaviors:
extern NSString *const NGRValueBehavior;
