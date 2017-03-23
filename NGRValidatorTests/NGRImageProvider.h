//
//  NGRImageProvider.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 23.03.2017.
//
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE

@interface UIImage (NGRImageProvider)
+ (UIImage *)ngr_imageWithSize:(CGSize)size;
@end

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

@interface NSImage (NGRImageProvider)
+ (UIImage *)ngr_imageWithSize:(CGSize)size;
@end

#endif



