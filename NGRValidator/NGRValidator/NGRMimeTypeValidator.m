//
//  NGRMimeTypeValidator.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidator.h"

// Extensions
#import "NGRMimeTypeValidator+Audio.h"
#import "NGRMimeTypeValidator+Misc.h"
#import "NGRMimeTypeValidator+Video.h"
#import "NGRMimeTypeValidator+Compressed.h"
#import "NGRMimeTypeValidator+Image.h"

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

+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size withOffset:(unsigned long)offset {
    return [[self alloc] initWithValidationBlock: ^BOOL(NSData *data) {
        
        if (data.length < offset + size) {
            return NO;
        }
        
        char bytes[size];
        NSRange range = NSMakeRange(offset, size);
        
        [data getBytes:&bytes range:range];
        return !memcmp(bytes, signature, size);
    }];
}

+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size {
    return [self validatorWithSignature:signature ofSize:size withOffset:0];
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
        
        NGRMimeTypeAvi : [NGRMimeTypeValidator avi],
        NGRMimeTypeMP4 : [NGRMimeTypeValidator mp4],
        NGRMimeTypeMov : [NGRMimeTypeValidator mov],
        NGRMimeTypeWMV : [NGRMimeTypeValidator wmv],
        NGRMimeTypeFlv : [NGRMimeTypeValidator flv],
        NGRMimeType3gp : [NGRMimeTypeValidator _3gp],
        NGRMimeTypeMkv : [NGRMimeTypeValidator mkv],
        NGRMimeTypeMPEG : [NGRMimeTypeValidator mpeg],
        
        NGRMimeTypePDF : [NGRMimeTypeValidator pdf],
        NGRMimeTypeUtf8Text : [NGRMimeTypeValidator utf8text],
        NGRMimeTypeJSON : [NGRMimeTypeValidator json],
        NGRMimeTypeXML : [NGRMimeTypeValidator xml],
        
        NGRMimeTypeFlac : [NGRMimeTypeValidator flac],
        NGRMimeTypeWav : [NGRMimeTypeValidator wav],
        NGRMimeTypeMP3 : [NGRMimeTypeValidator mp3],
        NGRMimeTypeM4a : [NGRMimeTypeValidator m4a],
        NGRMimeTypeOgg : [NGRMimeTypeValidator ogg],
        
        NGRMimeTypeTar : [NGRMimeTypeValidator tar],
        NGRMimeTypeGz : [NGRMimeTypeValidator gz],
        NGRMimeTypeRar : [NGRMimeTypeValidator rar],
        NGRMimeTypeZip : [NGRMimeTypeValidator zip],
        NGRMimeType7z : [NGRMimeTypeValidator _7z],
    };
}

@end

