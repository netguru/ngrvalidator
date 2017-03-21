//
//  NGRMimeTypeValidator+Misc.h
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@interface NGRMimeTypeValidator (Misc)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)pdf;
+ (instancetype)utf8text;
+ (instancetype)xml;
+ (instancetype)json;

NS_ASSUME_NONNULL_END

@end
