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

/**
 *  Validates property with user-defined condition.
 *
 *  @param selector The selector which implements custom validation. Selector has to return BOOL. Otherwise an exception will raise.
 *  @param target   The target specyfing where to search implementation of given selector.
 *  @param message  The message of an error returned when validation will fail.
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^condition)(id target, SEL selector, NSString *message);

#pragma mark - Messaging

/**
 *  User-defined error message used when the property is nil (default: cannot be nil).
 */
@property (nonatomic, readonly, copy) NGRPropertyValidator *(^isNil)(NSString *message);

@end
