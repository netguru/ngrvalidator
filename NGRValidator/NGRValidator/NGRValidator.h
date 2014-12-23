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
 *  Validates given model with selected rules. Returns YES when validation succeeded, NO otherwise.
 *
 *  @param model Model within properties are validated
 *  @param error Validation error with decription, nil when validation will pass
 *  @param rules An array of validation rules. Every property within a model is validated separately
 *  @return result of validation. YES if validation will pass, NO otherwise.
 */
+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error usingRules:(NSArray *(^)())rules;

/**
 *  Validates given model with selected rules. Returns empty array when validation succeeded. If not, array will contains errors.
 *
 *  @param model Model within properties are validated
 *  @param rules An array of validation rules. Every property within a model is validated separately
 *  @return an array of errors. If validation will pass then array is empty.
 */
+ (NSArray *)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules;

@end
