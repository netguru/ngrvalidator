//
//  NGRMimeTypeValidator+Image.h
//  NGRValidator
//
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
