//
//  NGRImage.h
//  NGRValidator
//
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

#import <AppKit/AppKit.h>

#endif

#if TARGET_OS_IPHONE

typedef UIImage NGRImage;

@interface UIImage (NGRValidator)
- (CGSize)ngr_pixelSize;
- (CGFloat)ngr_pixelRatio;
@end

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

typedef NSImage NGRImage;

@interface NSImage (NGRValidator) 
- (CGSize)ngr_pixelSize;
- (CGFloat)ngr_pixelRatio;
@end

#endif


