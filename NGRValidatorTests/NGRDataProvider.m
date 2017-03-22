//
//  NGRDataProvider.m
//  NGRValidator
//
//
//

#import "NGRDataProvider.h"

@implementation NGRDataProvider

#pragma mark - Image

+ (LazyNSData)jpg {
    return [self loadFile:@"logo" extension:@"jpg"];
}

+ (LazyNSData)png {
    return [self loadFile:@"logo" extension:@"png"];
}

+ (LazyNSData)tiff {
    return [self loadFile:@"logo" extension:@"tiff"];
}

+ (LazyNSData)ico {
    return [self loadFile:@"logo" extension:@"ico"];
}

+ (LazyNSData)gif {
    return [self loadFile:@"logo" extension:@"gif"];
}

+ (LazyNSData)bmp {
    return [self loadFile:@"logo" extension:@"bmp"];
}

#pragma mark - Video

+ (LazyNSData)_3gp {
    return [self loadFile:@"logo" extension:@"3gp"];
}

+ (LazyNSData)avi {
    return [self loadFile:@"logo" extension:@"avi"];
}

+ (LazyNSData)mkv {
    return [self loadFile:@"logo" extension:@"mkv"];
}

+ (LazyNSData)mp4 {
    return [self loadFile:@"logo" extension:@"mp4"];
}

+ (LazyNSData)wmv {
    return [self loadFile:@"logo" extension:@"wmv"];
}

+ (LazyNSData)flv {
    return [self loadFile:@"logo" extension:@"flv"];
}

+ (LazyNSData)mov {
    return [self loadFile:@"logo" extension:@"mov"];
}

+ (LazyNSData)mpeg {
    return [self loadFile:@"logo" extension:@"mpg"];
}

#pragma mark - Misc

+ (LazyNSData)pdf {
    return [self loadFile:@"logo" extension:@"pdf"];
}

+ (LazyNSData)xml {
    return [self loadFile:@"logo" extension:@"xml"];
}

+ (LazyNSData)json {
    return [self loadFile:@"logo" extension:@"json"];
}

+ (LazyNSData)utf8text {
    return ^{
        return [@"logo" dataUsingEncoding:NSUTF8StringEncoding];
    };
}

#pragma mark - Audio

+ (LazyNSData)wav {
    return [self loadFile:@"logo" extension:@"wav"];
}

+ (LazyNSData)m4a {
    return [self loadFile:@"logo" extension:@"m4a"];
}

+ (LazyNSData)flac {
    return [self loadFile:@"logo" extension:@"flac"];
}

+ (LazyNSData)ogg {
    return [self loadFile:@"logo" extension:@"ogg"];
}

+ (LazyNSData)mp3 {
    return [self loadFile:@"logo" extension:@"mp3"];
}

#pragma mark - Compressed

+ (LazyNSData)gz {
    return [self loadFile:@"logo" extension:@"tgz"];
}

+ (LazyNSData)zip {
    return [self loadFile:@"logo" extension:@"zip"];
}

+ (LazyNSData)tar {
    return [self loadFile:@"logo" extension:@"tar"];
}

+ (LazyNSData)rar {
    return [self loadFile:@"logo" extension:@"rar"];
}

+ (LazyNSData)_7z {
    return [self loadFile:@"logo" extension:@"7z"];
}

#pragma mark - Private

+ (NSBundle *)bundle {
    return [NSBundle bundleForClass:self];
}

+ (LazyNSData)loadFile:(NSString *)name extension:(NSString *)ext {
    NSBundle *bundle = [self bundle];
    
    return ^{
        NSURL *url = [bundle URLForResource:name withExtension:ext];
        return [NSData dataWithContentsOfURL:url];
    };
}

@end
