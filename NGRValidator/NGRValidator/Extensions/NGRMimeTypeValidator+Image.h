//
//  NGRMimeTypeValidator+Image.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Image)

NS_ASSUME_NONNULL_BEGIN

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains PNG file
 */
+ (instancetype)png;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains JPG file
 */
+ (instancetype)jpg;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Tiff file
 */
+ (instancetype)tiff;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Ico file
 */
+ (instancetype)ico;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains BMP file
 */
+ (instancetype)bmp;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Gif file
 */
+ (instancetype)gif;

NS_ASSUME_NONNULL_END

@end
