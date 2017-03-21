//
//  NGRMimeTypeValidator+Image.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 21.03.2017.
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Image)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)png;
+ (instancetype)jpg;
+ (instancetype)tiff;
+ (instancetype)ico;
+ (instancetype)bmp;
+ (instancetype)gif;

NS_ASSUME_NONNULL_END

@end
