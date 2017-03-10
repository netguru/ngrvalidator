//
//  NGRPropertyValidator+NSObject.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSObject)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Messaging

/**
 *  User-defined error message used when the property is nil (default: cannot be nil).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNil)(NSString *message);

NS_ASSUME_NONNULL_END

@end
