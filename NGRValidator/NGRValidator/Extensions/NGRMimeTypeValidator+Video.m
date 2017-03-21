//
//  NGRMimeTypeValidator+Video.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 21.03.2017.
//
//

#import "NGRMimeTypeValidator+Video.h"

@implementation NGRMimeTypeValidator (Video)

+ (instancetype)_3gp {
    const char signature1[8] = {0x00, 0x00, 0x00, 0x20, 0x66, 0x74, 0x79, 0x70};
    NGRMimeTypeValidator *_3gp1 = [self validatorWithSignature:signature1 ofSize:8];
    
    const char signature2[8] = {0x00, 0x00, 0x00, 0x14, 0x66, 0x74, 0x79, 0x70};
    NGRMimeTypeValidator *_3gp2 = [self validatorWithSignature:signature2 ofSize:8];
    
    return [self validatorWithAnyOfValidators:@[_3gp1, _3gp2]];
}

+ (instancetype)avi {
    
    const char signature[4] = {0x52, 0x49, 0x46, 0x46};
    NGRMimeTypeValidator *avi1 = [self validatorWithSignature:signature ofSize:4];
    
    const char subsignature[4] = {0x41, 0x56, 0x49, 0x20};
    NGRMimeTypeValidator *avi2 = [self validatorWithSignature:subsignature ofSize:4 withOffset:8];

    return [self validatorWithAllOfValidators:@[avi1, avi2]];
}

+ (instancetype)mkv {
    const char signature[4] = {0x1a, 0x45, 0xdf, 0xa3};
    return [self validatorWithSignature:signature ofSize:4];
}

+ (instancetype)mp4 {
    const char signature[4] = {0x6d, 0x6d, 0x70, 0x34};
    return [self validatorWithSignature:signature ofSize:4 withOffset:8];
}

+ (instancetype)wmv {
    const char signature[8] = {0x30, 0x26, 0xb2, 0x75, 0x8e, 0x66, 0xcf, 0x11};
    return [self validatorWithSignature:signature ofSize:8];
}

+ (instancetype)flv {
    const char signature[3] = {0x46, 0x4c, 0x56};
    return [self validatorWithSignature:signature ofSize:3];
}

+ (instancetype)mov {
    const char signature1[4] = {0x6d, 0x6f, 0x6f, 0x76};
    NGRMimeTypeValidator* mov1 = [self validatorWithSignature:signature1 ofSize:4 withOffset:4];
    
    const char signature2[4] = {0x66, 0x72, 0x65, 0x65};
    NGRMimeTypeValidator* mov2 = [self validatorWithSignature:signature2 ofSize:4 withOffset:4];
    
    const char signature3[4] = {0x6d, 0x64, 0x61, 0x74};
    NGRMimeTypeValidator* mov3 = [self validatorWithSignature:signature3 ofSize:4 withOffset:4];
    
    const char signature4[4] = {0x77, 0x69, 0x64, 0x65};
    NGRMimeTypeValidator* mov4 = [self validatorWithSignature:signature4 ofSize:4 withOffset:4];
    
    const char signature5[4] = {0x70, 0x6e, 0x6f, 0x74};
    NGRMimeTypeValidator* mov5 = [self validatorWithSignature:signature5 ofSize:4 withOffset:4];
    
    const char signature6[4] = {0x73, 0x6b, 0x69, 0x70};
    NGRMimeTypeValidator* mov6 = [self validatorWithSignature:signature6 ofSize:4 withOffset:4];
    
    return [self validatorWithAnyOfValidators:@[mov1, mov2, mov3, mov4, mov5, mov6]];
}

+ (instancetype)mpeg {
    const char signature1[4] = {0x00, 0x00, 0x01, 0xb3};
    NGRMimeTypeValidator* mpeg1 = [self validatorWithSignature:signature1 ofSize:4];
    
    const char signature2[4] = {0x00, 0x00, 0x01, 0xba};
    NGRMimeTypeValidator* mpeg2 = [self validatorWithSignature:signature2 ofSize:4];
    
    return [self validatorWithAnyOfValidators:@[mpeg1, mpeg2]];
}


@end
