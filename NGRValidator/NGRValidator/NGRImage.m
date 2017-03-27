//
//  NGRImage.m
//  NGRValidator
//

#import "NGRImage.h"

#if TARGET_OS_IPHONE

@implementation UIImage (NGRValidator)

- (CGSize)ngr_pixelSize {
    CGImageRef cgImage = self.CGImage;
    return CGSizeMake(CGImageGetWidth(cgImage), CGImageGetHeight(cgImage));
}

- (CGFloat)ngr_pixelRatio {
    CGSize pixelSize = [self ngr_pixelSize];
    return pixelSize.width / pixelSize.height;
}

@end

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

@implementation NSImage (NGRValidator)

- (CGSize)ngr_pixelSize {
    NSImageRep *imageRep = [self.representations firstObject];
    return CGSizeMake(imageRep.pixelsWide, imageRep.pixelsHigh);
}

- (CGFloat)ngr_pixelRatio {
    CGSize pixelSize = [self ngr_pixelSize];
    return pixelSize.width / pixelSize.height;
}

@end

#endif
