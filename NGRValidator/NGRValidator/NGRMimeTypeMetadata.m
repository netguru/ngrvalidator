//
//  NGRMimeTypeMetadata.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeMetadata.h"

@implementation NGRMimeTypeMetadata

- (instancetype)initWithName:(NGRMimeType *)name signature:(const char *)signature length:(unsigned long)length {
    self = [super init];
    if (self) {
        _signature = signature;
        _length = length;
        _name = name;
    }
    return self;
}

@end
