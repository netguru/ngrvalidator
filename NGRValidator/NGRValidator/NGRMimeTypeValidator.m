//
//  NGRMimeTypeValidator.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

@implementation NGRMimeTypeValidator

- (instancetype)initWithValidationBlock:(NGRMimeTypeValidationBlock)block {
    self = [super init];
    if (self) {
        _isValid = block;
    }
    return self;
}

+ (instancetype)validatorWithValidationBlock:(NGRMimeTypeValidationBlock)block {
    return [[self alloc] initWithValidationBlock:block];
}

+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size {
    return [[self alloc] initWithValidationBlock: ^BOOL(NSData *data) {
        char bytes[size];
        
        [data getBytes:&bytes length:size];
        return !memcmp(bytes, signature, size);
    }];
}

+ (instancetype)validatorWithAnyOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators {
    return [[self alloc] initWithValidationBlock: ^BOOL(NSData *data) {
        
        for (NGRMimeTypeValidator *validator in validators) {
            if (validator.isValid(data)) {
                return YES;
            }
        }
        
        return NO;
    }];
}

+ (instancetype)validatorWithAllOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators {
    return [[self alloc] initWithValidationBlock: ^BOOL(NSData *data) {
        
        for (NGRMimeTypeValidator *validator in validators) {
            if (!validator.isValid(data)) {
                return NO;
            }
        }
        
        return YES;
    }];
}


+ (NGRMimeTypeValidator *)validatorForMimeType:(NGRMimeType *)type {
    return [self validatorByMimeTypeKey][type];
}

+ (NSDictionary *)validatorByMimeTypeKey {

    return @{
        NGRMimeTypePNG : [NGRMimeTypeValidator png],
        NGRMimeTypeJPG : [NGRMimeTypeValidator jpg],
        NGRMimeTypeIco : [NGRMimeTypeValidator ico],
        NGRMimeTypeBMP : [NGRMimeTypeValidator bmp],
        NGRMimeTypeTiff : [NGRMimeTypeValidator tiff],
        NGRMimeTypeGif : [NGRMimeTypeValidator gif],
    };
}

@end


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
//
//@implementation NGRMimeTypeValidator (Video)
//
//+ (instancetype)_3gp {
//    
//}
//
//+ (instancetype)avi {
//    
//}
//
//+ (instancetype)mkv {
//    
//}
//
//+ (instancetype)mp4 {
//    
//}
//
//@end
//
//@implementation NGRMimeTypeValidator (Audio)
//
//+ (instancetype)wav {
//    
//}
//
//+ (instancetype)mp3 {
//    
//}
//
//+ (instancetype)flac {
//    
//}
//
//+ (instancetype)midi {
//    
//}
//
////MOVE
//
//+ (instancetype)tar {
//    
//}
//
//+ (instancetype)zip {
//    
//}
//
//+ (instancetype)rar {
//    
//}
//
//+ (instancetype)_7z {
//    
//}
//
//+ (instancetype)gz {
//    
//}
//
//// MOVE
//+ (instancetype)text {
//    
//}
//
//+ (instancetype)pdf {
//
//}
//
//+ (instancetype)xml {
//
//}
//
//@end
