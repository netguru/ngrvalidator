//
//  NGRDataProvider.h
//  NGRValidator
//
//
//

#import <Foundation/Foundation.h>

@interface NGRDataProvider : NSObject

#pragma mark - Image

+ (NSData *)jpg;
+ (NSData *)png;
+ (NSData *)tiff;
+ (NSData *)ico;
+ (NSData *)gif;
+ (NSData *)bmp;

#pragma mark - Video

+ (NSData *)_3gp;
+ (NSData *)avi;
+ (NSData *)mkv;
+ (NSData *)mp4;
+ (NSData *)wmv;
+ (NSData *)flv;
+ (NSData *)mov;
+ (NSData *)mpeg;

#pragma mark - Misc

+ (NSData *)pdf;
+ (NSData *)xml;
+ (NSData *)json;
+ (NSData *)utf8text;

#pragma mark - Audio

+ (NSData *)wav;
+ (NSData *)m4a;
+ (NSData *)flac;
+ (NSData *)ogg;
+ (NSData *)mp3;

#pragma mark - Compressed

+ (NSData *)gz;
+ (NSData *)zip;
+ (NSData *)tar;
+ (NSData *)rar;
+ (NSData *)_7z;

@end
