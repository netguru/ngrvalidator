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
 *  Validates wthether given object is included in validated array property or not.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^includes)(NSObject *object);

/**
 *  Validates wthether given object is excluded from validated array property or not.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^excludes)(NSObject *object);

#pragma mark - Messaging

/**
 *  User-defined error message used when object is not included in validated array property.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotIncludes)(NSString *message);

/**
 *  User-defined error message used when object is not excluded from validated array property.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExcludes)(NSString *message);

@end
