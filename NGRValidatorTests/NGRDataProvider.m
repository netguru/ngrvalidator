//
//  NGRDataProvider.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NGRDataProvider.h"

@implementation NGRDataProvider

#pragma mark - Image

+ (NSData *)jpg {
    return [self loadFile:@"logo" extension:@"jpg"];
}

+ (NSData *)png {
    return [self loadFile:@"logo" extension:@"png"];
}

+ (NSData *)tiff {
    return [self loadFile:@"logo" extension:@"tiff"];
}

+ (NSData *)ico {
    return [self loadFile:@"logo" extension:@"ico"];
}

+ (NSData *)gif {
    return [self loadFile:@"logo" extension:@"gif"];
}

+ (NSData *)bmp {
    return [self loadFile:@"logo" extension:@"bmp"];
}

#pragma mark - Video

+ (NSData *)_3gp {
    return [self loadFile:@"logo" extension:@"3gp"];
}

+ (NSData *)avi {
    return [self loadFile:@"logo" extension:@"avi"];
}

+ (NSData *)mkv {
    return [self loadFile:@"logo" extension:@"mkv"];
}

+ (NSData *)mp4 {
    return [self loadFile:@"logo" extension:@"mp4"];
}

+ (NSData *)wmv {
    return [self loadFile:@"logo" extension:@"wmv"];
}

+ (NSData *)flv {
    return [self loadFile:@"logo" extension:@"flv"];
}

+ (NSData *)mov {
    return [self loadFile:@"logo" extension:@"mov"];
}

+ (NSData *)mpeg {
    return [self loadFile:@"logo" extension:@"mpg"];
}

#pragma mark - Misc

+ (NSData *)pdf {
    return [self loadFile:@"logo" extension:@"pdf"];
}

+ (NSData *)xml {
    return [self loadFile:@"logo" extension:@"xml"];
}

+ (NSData *)json {
    return [self loadFile:@"logo" extension:@"json"];
}

+ (NSData *)utf8text {
    return [@"logo" dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - Audio

+ (NSData *)wav {
    return [self loadFile:@"logo" extension:@"wav"];
}

+ (NSData *)m4a {
    return [self loadFile:@"logo" extension:@"m4a"];
}

+ (NSData *)flac {
    return [self loadFile:@"logo" extension:@"flac"];
}

+ (NSData *)ogg {
    return [self loadFile:@"logo" extension:@"ogg"];
}

+ (NSData *)mp3 {
    return [self loadFile:@"logo" extension:@"mp3"];
}

#pragma mark - Compressed

+ (NSData *)gz {
    return [self loadFile:@"logo" extension:@"tgz"];
}

+ (NSData *)zip {
    return [self loadFile:@"logo" extension:@"zip"];
}

+ (NSData *)tar {
    return [self loadFile:@"logo" extension:@"tar"];
}

+ (NSData *)rar {
    return [self loadFile:@"logo" extension:@"rar"];
}

+ (NSData *)_7z {
    return [self loadFile:@"logo" extension:@"7z"];
}

#pragma mark - Private

+ (NSBundle *)bundle {
    return [NSBundle bundleForClass:self];
}

+ (NSData *)loadFile:(NSString *)name extension:(NSString *)ext {
    NSURL *url = [[self bundle] URLForResource:name withExtension:ext];
    return [NSData dataWithContentsOfURL:url];
}

@end
