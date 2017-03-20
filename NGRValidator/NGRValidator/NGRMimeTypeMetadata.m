//
//  NGRMimeTypeMetadata.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeMetadata.h"

@implementation NGRMimeTypeMetadata

- (instancetype)initWithSignature:(const char *)signature {
    self = [super init];
    if (self) {
        _signature = signature;
        _length = sizeof(signature)/sizeof(char);
    }
    return self;
}

+ (instancetype)dataWithSignature:(const char *)signature {
    return [[self alloc] initWithSignature:signature];
}

@end
