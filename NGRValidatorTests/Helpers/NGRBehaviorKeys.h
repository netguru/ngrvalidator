//
//  NGRBehaviorKeys.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 13.02.2015.
//
//


// helpers:
extern NSString *testDescriptor;
extern NSString *const msg;
extern NSDictionary * (^wrapData)(id validValue, id invalidValue, NSInteger errorCount, NGRPropertyValidator *(^)(NGRPropertyValidator *validator));

// data keys:
extern NSString *const NGRValidatorKey;
extern NSString *const NGRValidValueKey;
extern NSString *const NGRInvalidValueKey;
extern NSString *const NGRErrorCountKey;

// behaviors:
extern NSString *const NGRBehavior;
