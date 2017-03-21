//
//  NGRMimeTypeValidator+Compressed.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Compressed)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)tar;
+ (instancetype)zip;
+ (instancetype)rar;
+ (instancetype)_7z;
+ (instancetype)gz;

NS_ASSUME_NONNULL_END

@end
