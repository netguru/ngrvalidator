//
//  NSData+NGRValidator.m
//  NGRValidator
//

#import "NSData+NGRValidator.h"
#import "NGRMimeTypeValidator.h"

@implementation NSData (NGRValidator)

- (BOOL)ngr_hasMimeType:(NGRMimeType *)type {
    NGRMimeTypeValidator *validator = [NGRMimeTypeValidator validatorForMimeType:type];
    NSAssert(validator != nil, @"Detection not supported for this MIME type");
    
    return validator.isValid(self);
}

- (BOOL)ngr_isImage {
    NSArray<NGRMimeType *> *imageTypes = @[
        NGRMimeTypePNG,
        NGRMimeTypeIco,
        NGRMimeTypeGif,
        NGRMimeTypeTiff,
        NGRMimeTypeJPG,
        NGRMimeTypeBMP
    ];
    
    return [self ngr_hasOneOfTypes:imageTypes];
}

- (BOOL)ngr_isVideo {
    NSArray<NGRMimeType *> *videoTypes = @[
        NGRMimeType3gp,
        NGRMimeTypeAvi,
        NGRMimeTypeMkv,
        NGRMimeTypeMP4,
        NGRMimeTypeMPEG,
        NGRMimeTypeMov,
        NGRMimeTypeFlv,
        NGRMimeTypeWMV
    ];
    
    return [self ngr_hasOneOfTypes:videoTypes];
}


- (BOOL)ngr_isAudio {
    NSArray<NGRMimeType *> *audioTypes = @[
        NGRMimeTypeWav,
        NGRMimeTypeMP3,
        NGRMimeTypeFlac,
        NGRMimeTypeOgg,
        NGRMimeTypeM4a
    ];
    
    return [self ngr_hasOneOfTypes:audioTypes];
}

- (BOOL)ngr_isArchive {
    NSArray<NGRMimeType *> *archiveTypes = @[
        NGRMimeTypeZip,
        NGRMimeTypeRar,
        NGRMimeType7z,
        NGRMimeTypeTar,
        NGRMimeTypeGz
    ];
    
    return [self ngr_hasOneOfTypes:archiveTypes];
}

- (BOOL)ngr_hasOneOfTypes:(NSArray<NGRMimeType *> *)types {
    for (NGRMimeType *type in types) {
        if ([self ngr_hasMimeType:type]) {
            return YES;
        }
    }
    return NO;
}

@end
