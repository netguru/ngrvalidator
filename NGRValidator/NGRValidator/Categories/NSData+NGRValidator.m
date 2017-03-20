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
    
    NSDictionary *metadataDictionary = [self metadataByMimeTypeKey];
    NGRMimeTypeMetadata *metadata = metadataDictionary[type];
    
    NSAssert(metadata != nil, @"Detection not supported for this type");
    
    char bytes[32];
    [self getBytes:&bytes length:metadata.length];
    
    return !memcmp(bytes, metadata.signature, metadata.length);
}

- (NSDictionary *)metadataByMimeTypeKey {
    // Image signatures
    const char png[8] = {0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a};
    
    // Video signatures
    
    // Misc signatures
    
    return @{
        NGRMimeTypePNG : [NGRMimeTypeMetadata dataWithSignature:png]
    };
}

@end
