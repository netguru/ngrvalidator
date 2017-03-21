//
//  NGRMimeTypeValidator+Audio.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Audio)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)wav;
+ (instancetype)mp3;
+ (instancetype)flac;
+ (instancetype)m4a;
+ (instancetype)ogg;

NS_ASSUME_NONNULL_END

@end
