//
//  NGRPropertyValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

#import "NGRMessaging.h"
#import "NGRMessages.h"
#import "NGRConstants.h"

extern NSUInteger const NGRPropertyValidatorDefaultPriority;

@interface NGRPropertyValidator : NSObject

/**
 *  Designed Initializer for validator. Don't use any other initializers.
 *
 *  @param property Name of property given as NSString.
 *  @return Instance of NGPropertyValidator used to specify next validation rules.
 */
- (instancetype)initWithProperty:(NSString *)property NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Name of validated property.
 */
@property (strong, nonatomic, readonly) NSString *property;

/**
 * The delegate that responds to NGRMessaging protocol methods.
 */
@property (weak, nonatomic) id<NGRMessaging> delegate;

/**
 * Localized name of validated property. Used in error description if has been set. (default: nil).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^localizedName)(NSString *name);

/**
 *  Validates that the NSObject is nil or not.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^required)();

/**
 *  Whether the validated property can be empty (means it's length or count is equal to 0). By default cannot be empty.
 *  When is allowed to be empty, validator will pass validation when property will be empty. Works for both required() and non-required rules.
 *
 *  Refers to NSString, NSAttributedString, NSData, NSArray, NSSet, NSDictionary (and their mutable counterparts).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^allowEmpty)();

/**
 *  Sets priority of property validator. During validation proccess, property validators will be invoke one by one ordered by priority.
 *  Default: All property validators have same priority and will be invoked in order of NSArray order returned in rules: block.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^order)(NSUInteger);

/**
 *  Sets scenarios which property validator has to conform. Do not use if property should be validate in every scenario.
 *  Remember to pass scenario names as NSStrings.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^onScenarios)(NSArray *scenarios);

/**
 *  A scenarios which property validator conforms. If nil, property validator will be valid in every scenario.
 */
@property (strong, nonatomic, readonly) NSMutableArray *scenarios;

/**
 *  Scenario used during validation process.
 */
@property (strong, nonatomic) NSString *scenario;

/**
 *  Priority of property validator. Default equal to NGRPropertyValidatorDefaultPriority (100).
 */
@property (assign, readonly, nonatomic) NSUInteger priority;

/**
 *  Array of NGRValidationRule objects, invoked one by one in validation process.
 */
@property (strong, nonatomic, readonly) NSMutableArray *validationRules;

/**
 *  Validation error messages handler.
 */
@property (strong, nonatomic, readonly) NGRMessages *messages;

/**
 *  Validates property to first error.
 *
 *  @param value The value of validated property.
 *  @return NSError The error if any, otherwise nil.
 */
- (NSError *)simpleValidationOfValue:(id)value;

/**
 *  Validates property and gather all possible errors.
 *
 *  @param value The value of validated property.
 *  @return An NSArray of errors if any, otherwise nil.
 */
- (NSArray *)complexValidationOfValue:(id)value;

/**
 *  Adds a validator block to validators. Also checks if validated property is kind of given class.
 *
 *  @param aClass           The class which given property should be. If nil, class validation will be skipped.
 *  @param name             The name of validator block.
 *  @param validationBlock  The validation block invoked during validation process.
 */
- (void)validateClass:(Class)aClass withName:(NSString *)name validationBlock:(NGRValidationBlock)block;

@end
