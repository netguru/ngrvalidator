//
//  NGRPropertyValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRMessages.h"

extern NSUInteger const NGRPropertyValidatorDefaultPriority;

@interface NGRPropertyValidator : NSObject

/**
 *  Designed Initializer for validator. Don't use any other initializers.
 *
 *  @param property Name of property given as NSString.
 *  @return Instance of NGPropertyValidator used to specify next validation rules.
 */
- (instancetype)initWithProperty:(NSString *)property NS_DESIGNATED_INITIALIZER;

/**
 *  Name of validated property.
 */
@property (strong, nonatomic, readonly) NSString *property;

/**
 * Localized name of validated property. Used in localized description of error if has been set. (default: nil).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^localizedName)(NSString *name);

/**
 *  Validates that the NSObject is nil or not.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^required)();

/**
 *  Whether the validated property can be empty (means its length or count is greater than 0) when is required. (default: cannot be empty)
 *  When is not allowed to be empty (by default), validator will treat empty property same as nil.
 *  Setting allowEmpty works only when property is also required. Otherwise has no effect.
 *  Refers to NSString, NSAttributedString, NSData, NSArray, NSSet, NSDictionary (and its mutable counterparts).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^allowEmpty)();

/**
 *  Sets priority of property validator. During validation proccess, property validators will be invoke one by one ordered by priority.
 *  Default: All property validators have same priority and will be invoked in order of NSArray order returned in usingRules: block.
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
 *  Describes scenario used during validation process.
 */
@property (strong, nonatomic) NSString *scenario;

/**
 *  Priority of property validator. Default equal to NGRPropertyValidatorDefaultPriority (100).
 */
@property (assign, readonly, nonatomic) NSUInteger priority;

/**
 *  Array of NGRValidationRule objects, invoked one by one in validation proccess.
 */
@property (strong, nonatomic, readonly) NSMutableArray *validationRules;

/**
 * Dictionary of error - message pairs.
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
 *  @return An NSArray of errrors if any, otherwise nil.
 */
- (NSArray *)complexValidationOfValue:(id)value;

/**
 *  Adds a validator block to validators. Also checks if validated property is kind of given class.
 *
 *  @param aClass           The class which given property should be. If nil, class validation will be skipped
 *  @param name             The name of validator block
 *  @param validationBlock  The validation block invoked during validation proccess.
 */
- (void)validateClass:(Class)aClass withName:(NSString *)name validationBlock:(NGRValidationBlock)block;

@end
