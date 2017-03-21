//
//  NGRMimeTypeValidator+Audio.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 21.03.2017.
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Audio)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)wav;
+ (instancetype)mp3;
+ (instancetype)flac;
+ (instancetype)midi;

NS_ASSUME_NONNULL_END

@end
