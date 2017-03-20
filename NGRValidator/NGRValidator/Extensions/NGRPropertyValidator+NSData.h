//
//  NGRPropertyValidator+NSData.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NGRMimeType.h"
#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSData)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Rules

/**
 *  Validates if NSData property has given MIME type.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^mimeType)(NGRMimeType *mimeType);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property has wrong MIME type.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongMIMEType)(NSString *message);

NS_ASSUME_NONNULL_END

@end
