//
//  NGRPropertyValidator+NSObject.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSObject)

#pragma mark - Rules

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^includedIn)(NSArray *array);

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^excludedFrom)(NSArray *array);

#pragma mark - Messaging

/**
 *  User-defined error message used when the property is nil (default: cannot be nil).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNil)(NSString *message);

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotIncludedIn)(NSString *message);

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExcludedFrom)(NSString *message);

@end
