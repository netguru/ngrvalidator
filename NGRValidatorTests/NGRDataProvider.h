//
//  NGRDataProvider.h
//  NGRValidator
//
//
//

#import <Foundation/Foundation.h>

typedef NSData*(^LazyNSData)();

@interface NGRDataProvider : NSObject

#pragma mark - Image

+ (LazyNSData)jpg;
+ (LazyNSData)png;
+ (LazyNSData)tiff;
+ (LazyNSData)ico;
+ (LazyNSData)gif;
+ (LazyNSData)bmp;

#pragma mark - Video

+ (LazyNSData)_3gp;
+ (LazyNSData)avi;
+ (LazyNSData)mkv;
+ (LazyNSData)mp4;
+ (LazyNSData)wmv;
+ (LazyNSData)flv;
+ (LazyNSData)mov;
+ (LazyNSData)mpeg;

#pragma mark - Misc

+ (LazyNSData)pdf;
+ (LazyNSData)xml;
+ (LazyNSData)json;
+ (LazyNSData)utf8text;

#pragma mark - Audio

+ (LazyNSData)wav;
+ (LazyNSData)m4a;
+ (LazyNSData)flac;
+ (LazyNSData)ogg;
+ (LazyNSData)mp3;

#pragma mark - Compressed

+ (LazyNSData)gz;
+ (LazyNSData)zip;
+ (LazyNSData)tar;
+ (LazyNSData)rar;
+ (LazyNSData)_7z;

@end
