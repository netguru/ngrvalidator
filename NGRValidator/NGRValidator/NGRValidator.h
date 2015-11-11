//
//  NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRValidatorUmbrellaHeader.h"

@interface NGRValidator : NSObject

/**
 *  Validates single value with given rules.
 *
 *  @param value The value which will be validated.
 *  @param name  The name of validated value. Passing name here, has same effect as using .localizedName(NSString *) method from NGRPropertyValidator (invoking this method in rules block is unnecessary).
 *  @param rules The rules block which pass prepared validator as an argument ready to apply validation rules.
 *
 *  @return an error if validation will not pass. Otherwise nil.
 */
+ (NSError *)validateValue:(NSObject *)value named:(NSString *)name rules:(void (^)(NGRPropertyValidator *validator))rules;

/**
 *  Validates model with given rules. Returns YES when validation succeeded, NO otherwise.
 *
 *  @param model    Model with properties to validate.
 *  @param error    Validation error with description, nil when validation will pass.
 *  @param delegate Allows delegate to customize entire error messages.
 *  @param rules    An array of validation rules. Every property in model is validated separately.
 *
 *  @return result of validation. YES if validation will pass, NO otherwise.
 */
+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules;

/**
 *  Validates model with given rules. Returns YES when validation succeeded, NO otherwise.
 *
 *  @param model    Model with properties to validate.
 *  @param error    Validation error with description, nil when validation will pass.
 *  @param scenario The scenario specifying which properties of model should be validated.
 *  @param delegate Allows delegate to customize entire error messages.
 *  @param rules    An array of validation rules. Every property in model is validated separately.
 *
 *  @return result of validation. YES if validation will pass, NO otherwise.
 */
+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error scenario:(NSString *)scenario delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules;

/**
 *  Validates model with given rules. Returns empty array when validation succeeded. If not, array will contains errors.
 *
 *  @param model    Model with properties to validate.
 *  @param delegate Allows delegate to customize entire error messages.
 *  @param rules    An array of validation rules. Every property within a model is validated separately.
 *
 *  @return Nil if validation will pass, otherwise an array populated with validation errors.
 */
+ (NSArray *)validateModel:(NSObject *)model delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules;

/**
 *  Validates model with given rules and scenario. Returns empty array when validation succeeded. If not, array will contains errors.
 *
 *  @param model    Model with properties to validate.
 *  @param scenario The scenario specifying which properties of model should be validated.
 *  @param delegate Allows delegate to customize entire error messages.
 *  @param rules    An array of validation rules. Every property within a model is validated separately.
 *
 *  @return Nil if validation will pass, otherwise an array populated with validation errors.
 */
+ (NSArray *)validateModel:(NSObject *)model scenario:(NSString *)scenario delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules;

@end

@interface NGRValidator (Deprecated)

+ (NSError *)validateValue:(NSObject *)value named:(NSString *)name usingRules:(void (^)(NGRPropertyValidator *validator))rules NGR_DEPRECATED_USE_INSTEAD("validateValue:named:rules");

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error usingRules:(NSArray *(^)())rules NGR_DEPRECATED_USE_INSTEAD("validateModel:error:delegate:rules:");

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules NGR_DEPRECATED_USE_INSTEAD("validateModel:error:scenario:delegate:rules:");

+ (NSArray *)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules NGR_DEPRECATED_USE_INSTEAD("validateModel:delegate:rules:");

+ (NSArray *)validateModel:(NSObject *)model scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules NGR_DEPRECATED_USE_INSTEAD("validateModel:scenario:delegate:rules:");

@end
