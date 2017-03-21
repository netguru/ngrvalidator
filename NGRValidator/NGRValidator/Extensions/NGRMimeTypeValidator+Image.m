//
//  NGRMimeTypeValidator+Image.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 21.03.2017.
//
//

#import "NGRMimeTypeValidator+Image.h"

@implementation NGRMimeTypeValidator (Image)

+ (instancetype)png {
    const char signature[] = {0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a};
    return [self validatorWithSignature:signature ofSize:8];
}

+ (instancetype)jpg {
    const char signature[] = {0xff, 0xd8};
    return [self validatorWithSignature:signature ofSize:2];
}

+ (instancetype)ico {
    const char signature[] = {0x00, 0x00, 0x01, 0x00};
    return [self validatorWithSignature:signature ofSize:4];
}

+ (instancetype)bmp {
    const char signature[] = {0x42, 0x4d};
    return [self validatorWithSignature:signature ofSize:2];
}

+ (instancetype)tiff {
    const char signature_1[] = {0x49, 0x49, 0x2a, 0x00};
    NGRMimeTypeValidator *tiff_1 = [self validatorWithSignature:signature_1 ofSize:4];
    
    const char signature_2[] = {0x4d, 0x4d, 0x00, 0x2a};
    NGRMimeTypeValidator *tiff_2 = [self validatorWithSignature:signature_2 ofSize:4];
    
    return [self validatorWithAnyOfValidators:@[tiff_1, tiff_2]];
}

+ (instancetype)gif {
    const char signature_1[] = {0x47, 0x49, 0x46, 0x38, 0x37, 0x61};
    NGRMimeTypeValidator *gif_1 = [self validatorWithSignature:signature_1 ofSize:6];
    
    const char signature_2[] = {0x47, 0x49, 0x46, 0x38, 0x39, 0x61};
    NGRMimeTypeValidator *gif_2 = [self validatorWithSignature:signature_2 ofSize:6];
    
    return [self validatorWithAnyOfValidators:@[gif_1, gif_2]];
}

@end
