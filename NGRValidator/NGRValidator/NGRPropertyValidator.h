//
//  NGRPropertyValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRErrors.h"

typedef NGRError (^NGRValidationBlock)(id);

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
 *  Array of validator blocks invoked one by one in validation proccess.
 */
@property (strong, nonatomic, readonly) NSMutableArray *validators;

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
 *  @param aClass          The class which given property should be. If nil, class validation will be skipped
 *  @param validationBlock The validation block invoked during validation proccess.
 */
- (void)validateClass:(Class)aClass withBlock:(NGRValidationBlock)validationBlock;

@end
