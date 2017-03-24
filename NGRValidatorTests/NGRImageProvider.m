//
//  NGRImageProvider.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 23.03.2017.
//
//

#import "NGRImageProvider.h"

#if TARGET_OS_IPHONE

@implementation UIImage (NGRImageProvider)

+ (UIImage *)ngr_imageWithSize:(CGSize)size {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize scaledSize = CGSizeMake(size.width / scale, size.height / scale);
    UIGraphicsBeginImageContextWithOptions(scaledSize, YES, 0);
    
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectMake(0, 0, scaledSize.width, scaledSize.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

@implementation NSImage (NGRImageProvider)

+ (NSImage *)ngr_imageWithSize:(CGSize)size {
    
    CGFloat scale = [[NSScreen mainScreen] backingScaleFactor];
    
    CGSize scaledSize = CGSizeMake(size.width / scale, size.height / scale);
    NSImage *image = [[NSImage alloc] initWithSize:scaledSize];
    
    [image lockFocus];
    
    [[NSColor whiteColor] setFill];
    NSRectFill(CGRectMake(0, 0, scaledSize.width,scaledSize.height));
    
    [image unlockFocus];
    
    return image;
}

@end

#endif
