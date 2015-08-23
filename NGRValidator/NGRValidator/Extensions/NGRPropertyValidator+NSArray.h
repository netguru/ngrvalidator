//
//  NGRPropertyValidator+NSArray.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21/07/15.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSArray)

#pragma mark - Rules

/**
 *  Validates whether given object is included in validated array property or not.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^includes)(NSObject *object);

/**
 *  Validates whether given object is excluded from validated array property or not.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^excludes)(NSObject *object);

/**
 *  Validates whether validated property is included in given array.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^includedIn)(NSArray *array);

/**
 *  Validates whether validated property is excluded from given array.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^excludedFrom)(NSArray *array);

#pragma mark - Messaging

/**
 *  User-defined error message used when object is not included in validated array property.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotIncludes)(NSString *message);

/**
 *  User-defined error message used when object is not excluded from validated array property.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExcludes)(NSString *message);

/**
 *  User-defined error message used when the property is not included in array.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotIncludedIn)(NSString *message);

/**
 *  User-defined error message used when the property is not excluded from array.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExcludedFrom)(NSString *message);

@end
