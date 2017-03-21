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

+ (NSData *)pdf {
    return [self loadFile:@"logo" extension:@"pdf"];
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

#pragma mark - Private

+ (NSBundle *)bundle {
    return [NSBundle bundleForClass:self];
}

+ (NSData *)loadFile:(NSString *)name extension:(NSString *)ext {
    NSURL *url = [[self bundle] URLForResource:name withExtension:ext];
    return [NSData dataWithContentsOfURL:url];
}

@end
