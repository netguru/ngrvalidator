//
//  NGRMimeTypeValidator+Audio.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator+Audio.h"

@implementation NGRMimeTypeValidator (Audio)

+ (instancetype)wav {
    const char signature[4] = {0x52, 0x49, 0x46, 0x46};
    NGRMimeTypeValidator *wav1 = [self validatorWithSignature:signature ofSize:4];
    
    const char subsignature[4] = {0x57, 0x41, 0x56, 0x45};
    NGRMimeTypeValidator *wav2 = [self validatorWithSignature:subsignature ofSize:4 withOffset:8];
    
    return [self validatorWithAllOfValidators:@[wav1, wav2]];
}

+ (instancetype)mp3 {
    const char signature1[3] = {0x49, 0x44, 0x33};
    NGRMimeTypeValidator *mp3_1 = [self validatorWithSignature:signature1 ofSize:3];
    
    const char signature2[2] = {0xff, 0xfb};
    NGRMimeTypeValidator *mp3_2 = [self validatorWithSignature:signature2 ofSize:2];
    
    return [self validatorWithAnyOfValidators:@[mp3_1, mp3_2]];
}

+ (instancetype)flac {
    const char signature[8] = {0x66, 0x4c, 0x61, 0x43, 0x00, 0x00, 0x00, 0x22};
    return [self validatorWithSignature:signature ofSize:8];
}

+ (instancetype)m4a {
    const char signature[7] = {0x66, 0x74, 0x79, 0x70, 0x4d, 0x34, 0x41};
    return [self validatorWithSignature:signature ofSize:7 withOffset:4];
}

+ (instancetype)ogg {
    const char signature[8] = {0x4f, 0x67, 0x67, 0x53, 0x00, 0x02, 0x00, 0x00};
    return [self validatorWithSignature:signature ofSize:8];
}

@end
