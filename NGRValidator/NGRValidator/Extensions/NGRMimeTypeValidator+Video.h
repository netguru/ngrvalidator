//
//  NGRMimeTypeValidator+Video.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Video)

NS_ASSUME_NONNULL_BEGIN

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains 3gp file
 */
+ (instancetype)_3gp;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Avi file
 */
+ (instancetype)avi;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Mkv file
 */
+ (instancetype)mkv;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains MP4 file
 */
+ (instancetype)mp4;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Mov file
 */
+ (instancetype)mov;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains WMV file
 */
+ (instancetype)wmv;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Flv file
 */
+ (instancetype)flv;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains MPEG file
 */
+ (instancetype)mpeg;

NS_ASSUME_NONNULL_END

@end
