//
//  NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRPropertyValidator+NSString.h"
#import "NGRPropertyValidator+NSObject.h"
#import "NGRPropertyValidator+NSNumber.h"
#import "NGRPropertyValidator+Syntax.h"
#import "NGRPropertyValidator+NSDate.h"

@interface NGRValidator : NSObject

/**
 *  Defines validated property and initialize validation
 *
 *  @param  property Name of property given as NSString.
 *  @return instance of NGPropertyValidator used to specify next validation rules
 */
extern NGRPropertyValidator * NGRValidate(NSString *property);

/**
 *  Validates single value with given rules.
 *
 *  @param value The value which will be validated.
 *  @param name  The name of validated value. Passing name here same has effect to .localizedName(NSString *) method from NGRPropertyValidator (invoking this method in rules block is unnecessary).
 *  @param rules The rules block which pass prepared validator as an argument ready to apply validation rules.
 *
 *  @return an error if validation will not pass. Otherwise nil.
 */
+ (NSError *)validateValue:(NSObject *)value named:(NSString *)name usingRules:(void (^)(NGRPropertyValidator *validator))rules;

/**
 *  Validates model with given rules. Returns YES when validation succeeded, NO otherwise.
 *
 *  @param model Model within properties are validated.
 *  @param error Validation error with decription, nil when validation will pass.
 *  @param rules An array of validation rules. Every property within a model is validated separately.
 *
 *  @return result of validation. YES if validation will pass, NO otherwise.
 */
+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error usingRules:(NSArray *(^)())rules;

/**
 *  Validates model with given rules and scenario. Returns YES when validation succeeded, NO otherwise.
 *
 *  @param model Model within properties are validated.
 *  @param error Validation error with decription, nil when validation will pass.
 *  @param scenario The scenario specifying which properties of model should be validated.
 *  @param rules An array of validation rules. Every property within a model is validated separately.
 *
 *  @return result of validation. YES if validation will pass, NO otherwise.
 */
+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules;

/**
 *  Validates model with given rules. Returns empty array when validation succeeded. If not, array will contains errors.
 *
 *  @param model Model within properties are validated.
 *  @param rules An array of validation rules. Every property within a model is validated separately.
 *
 *  @return an array of errors. Nil if validation will pass, otherwise will contain NSError objects.
 */
+ (NSArray *)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules;

/**
 *  Validates model with given rules and scenario. Returns empty array when validation succeeded. If not, array will contains errors.
 *
 *  @param model Model within properties are validated.
 *  @param scenario The scenario specifying which properties of model should be validated.
 *  @param rules An array of validation rules. Every property within a model is validated separately.
 *
 *  @return an array of errors. Nil if validation will pass, otherwise will contain NSError objects.
 */
+ (NSArray *)validateModel:(NSObject *)model scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules;

@end
