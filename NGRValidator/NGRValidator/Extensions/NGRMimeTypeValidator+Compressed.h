//
//  NGRMimeTypeValidator+Compressed.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Compressed)

NS_ASSUME_NONNULL_BEGIN

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Tar archive
 */
+ (instancetype)tar;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Zip archive
 */
+ (instancetype)zip;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Rar archive
 */
+ (instancetype)rar;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains 7z archive
 */
+ (instancetype)_7z;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains GZip archive
 */
+ (instancetype)gz;

NS_ASSUME_NONNULL_END

@end
