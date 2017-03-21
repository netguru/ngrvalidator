//
//  NGRDataProvider.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
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

#pragma mark - Video

+ (NSData *)pdf;
+ (NSData *)xml;
+ (NSData *)json;
+ (NSData *)utf8text;

#pragma mark - Video

+ (NSData *)wav;
+ (NSData *)m4a;
+ (NSData *)flac;
+ (NSData *)ogg;
+ (NSData *)mp3;

@end
