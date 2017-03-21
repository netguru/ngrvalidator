//
//  NGRMimeTypeValidationTestCase.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidationTestCase.h"

@implementation NGRMimeTypeValidationTestCase

- (instancetype)initWithMimeType:(NGRMimeType *)type validData:(NSData *)valid invalidData:(NSData *)invalid {
    self = [super init];
    if (self) {
        _mimeType = type;
        _validData = valid;
        _invalidData = invalid;
    }
    return self;
}

+ (instancetype)test:(NGRMimeType *)type valid:(NSData *)valid invalid:(NSData *)invalid {
    return [[self alloc] initWithMimeType:type validData:valid invalidData:invalid];
}

- (NSString *)name {
    NSString *typeName = [[self.mimeType componentsSeparatedByString:@"/"] lastObject];
    return [NSString stringWithFormat:@"Validation of %@", typeName];
}

@end
