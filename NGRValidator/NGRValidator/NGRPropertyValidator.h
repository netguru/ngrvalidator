//
//  NGRPropertyValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRErrors.h"
#import "NGRValidationRule.h"

extern NSUInteger const NGRPropertyValidatorDefaultPriority;

@interface NGRPropertyValidator : NSObject

/**
 *  Designed Initializer for validator. Don't use any other initializers.
 *
 *  @param property Name of property given as NSString.
 *  @return Instance of NGPropertyValidator used to specify next validation rules.
 */
+ (NGRPropertyValidator *)validatorForProperty:(NSString *)property;

/**
 *  Name of validated property.
 */
@property (strong, readonly, nonatomic) NSString *property;

/**
 * Localized name of validated property. Used in localized description of error if has been set. (default: nil).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^localizedName)(NSString *name);

/**
 *  Validates that the NSObject is nil or not.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^required)();

/**
 *  Sets priority of property validator. During validation proccess, property validators will be invoke one by one ordered by priority.
 *  Default behaviour: All property validators have same priority and will be invoke in order of NSArray order given in
 *  [NGRValidator validateModel:error:usingRules:] or [NGRValidator validateModel:usingRules:] method.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^order)(NSUInteger);

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
@property (strong, nonatomic, readonly) NSMutableDictionary *messages;

/**
 *  Sets a message for the given error.
 *
 *  @param message  The message you want to set.
 *  @param error    The error, for which you want to set the message.
 */
- (void)setMessage:(NSString *)message forError:(NGRError)error;

/**
 *  Retrieve message for given error.
 *
 *  @param error The error specifying which message should be returned.
 *  @return The message fo given error.
 */
- (NSString *)messageForError:(NGRError)error;

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
