//
//  NGRMimeTypeValidator+Misc.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 21.03.2017.
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
