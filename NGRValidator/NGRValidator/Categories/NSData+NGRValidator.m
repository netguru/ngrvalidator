//
//  NSData+NGRValidator.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NSData+NGRValidator.h"
#import "NGRMimeTypeMetadata.h"

@implementation NSData (NGRValidator)

- (BOOL)ngr_hasMimeType:(NGRMimeType *)type {
    char bytes[12] = {0};
    [self getBytes:&bytes length:12];
    
    const char png[8] = {0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a};
    NGRMimeTypeMetadata *metadata = [[NGRMimeTypeMetadata alloc] initWithName:NGRMimeTypePNG
                                                    signature: png
                                                       length:8];
    
    if (!memcmp(bytes, metadata.signature, metadata.length)) {
        return YES;
    }
    
    return NO;
}

@end
