//
//  NGRMimeTypeValidator+Misc.h
//  NGRValidator
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Misc)

NS_ASSUME_NONNULL_BEGIN

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains PDF file
 */
+ (instancetype)pdf;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains UTF8 encoded string
 */
+ (instancetype)utf8text;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains XML
 */
+ (instancetype)xml;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains JSON
 */
+ (instancetype)json;

NS_ASSUME_NONNULL_END

@end
