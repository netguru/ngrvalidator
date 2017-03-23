//
//  NGRMimeTypeValidator+Misc.m
//  NGRValidator
//

#import "NGRMimeTypeValidator+Misc.h"

@implementation NGRMimeTypeValidator (Misc)

+ (instancetype)utf8text {
    return [self validatorWithValidationBlock:^BOOL(NSData * _Nonnull data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] != nil;
    }];
}

+ (instancetype)pdf {
    const char signature[4] = {0x25, 0x50, 0x44, 0x46};
    return [self validatorWithSignature:signature ofSize:4];
}

+ (instancetype)xml {
    const char signature[5] = {0x3C, 0x3F, 0x78, 0x6D, 0x6C};
    return [self validatorWithSignature:signature ofSize:5];
}

+ (instancetype)json {
    return [self validatorWithValidationBlock:^BOOL(NSData * _Nonnull data) {
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] != nil;
    }];
}

@end
