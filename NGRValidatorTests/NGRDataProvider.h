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
+ (NSData *)pdf;
+ (NSData *)tiff;
+ (NSData *)ico;
+ (NSData *)gif;

#pragma mark - Video

+ (NSData *)_3gp;
+ (NSData *)avi;
+ (NSData *)mkv;
+ (NSData *)mp4;
+ (NSData *)wmv;
+ (NSData *)flv;

@end
