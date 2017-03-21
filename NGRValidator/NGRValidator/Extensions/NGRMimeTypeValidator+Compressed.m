//
//  NGRMimeTypeValidator+Compressed.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator+Compressed.h"

@implementation NGRMimeTypeValidator (Compressed)

+ (instancetype)tar {
    const char signature[5] = {0x75, 0x73, 0x74, 0x61, 0x72};
    return [self validatorWithSignature:signature ofSize:5 withOffset:257];
}

+ (instancetype)zip {
    
    const char signature1[4] = {0x50, 0x4b, 0x03, 0x04};
    NGRMimeTypeValidator *zip1 = [self validatorWithSignature:signature1 ofSize:4];
    
    const char signature2[6] = {0x50, 0x4b, 0x4c, 0x49, 0x54, 0x45};
    NGRMimeTypeValidator *zip2 = [self validatorWithSignature:signature2 ofSize:6 withOffset:30];
    
    const char signature3[5] = {0x50, 0x4b, 0x53, 0x70, 0x58};
    NGRMimeTypeValidator *zip3 = [self validatorWithSignature:signature3 ofSize:5 withOffset:526];
    
    const char signature4[4] = {0x50, 0x4b, 0x05, 0x06};
    NGRMimeTypeValidator *zip4 = [self validatorWithSignature:signature4 ofSize:4];
    
    const char signature5[4] = {0x50, 0x4b, 0x07, 0x08};
    NGRMimeTypeValidator *zip5 = [self validatorWithSignature:signature5 ofSize:4];
    
    const char signature6[8] = {0x50, 0x4b, 0x03, 0x04, 0x14, 0x00, 0x01, 0x00};
    NGRMimeTypeValidator *zip6 = [self validatorWithSignature:signature6 ofSize:8];
    
    const char signature7[8] = {0x57, 0x69, 0x6e, 0x5a, 0x69, 0x70};
    NGRMimeTypeValidator *zip7 = [self validatorWithSignature:signature7 ofSize:6 withOffset:29152];
    
    return [self validatorWithAnyOfValidators:@[zip1, zip2, zip3, zip4, zip5, zip6, zip7]];
}

+ (instancetype)rar {
    const char signature[7] = {0x52, 0x61, 0x72, 0x21, 0x1a, 0x07, 0x00};
    return [self validatorWithSignature:signature ofSize:7];
}

+ (instancetype)_7z {
    const char signature[6] = {0x37, 0x7a, 0xbc, 0xaf, 0x27, 0x1c};
    return [self validatorWithSignature:signature ofSize:6];
}

+ (instancetype)gz {
    const char signature[3] = {0x1f, 0x8b, 0x08};
    return [self validatorWithSignature:signature ofSize:3];
}

@end

