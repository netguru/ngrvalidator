//
//  NGRDataProvider.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NGRDataProvider.h"

@implementation NGRDataProvider

+ (NSData *)jpg {
    return [self loadFile:@"logo" extension:@"jpg"];
}

+ (NSData *)png {
    return [self loadFile:@"logo" extension:@"png"];
}

+ (NSBundle *)bundle {
    return [NSBundle bundleForClass:self];
}

+ (NSData *)loadFile:(NSString *)name extension:(NSString *)ext {
    NSURL *url = [[self bundle] URLForResource:name withExtension:ext];
    return [NSData dataWithContentsOfURL:url];
}

@end
