//
//  NGRMimeTypeValidator+Audio.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Audio)

NS_ASSUME_NONNULL_BEGIN

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains WAV file
 */
+ (instancetype)wav;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains MP3 file
 */
+ (instancetype)mp3;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains flac file
 */
+ (instancetype)flac;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains m4a file
 */
+ (instancetype)m4a;

/**
 * Returns NGRMimeTypeValidator capable of checking whether NSData contains Ogg file
 */
+ (instancetype)ogg;

NS_ASSUME_NONNULL_END

@end
