//
//  NGRMimeTypeValidator+Video.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 21.03.2017.
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Video)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)_3gp;
+ (instancetype)avi;
+ (instancetype)mkv;
+ (instancetype)mp4;

NS_ASSUME_NONNULL_END

@end
