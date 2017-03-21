//
//  NGRMimeType.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import <Foundation/Foundation.h>

@interface NGRMimeType : NSString @end

#pragma mark - Image

extern NGRMimeType *const NGRMimeTypePNG;
extern NGRMimeType *const NGRMimeTypeIco;
extern NGRMimeType *const NGRMimeTypeGif;
extern NGRMimeType *const NGRMimeTypeTiff;
extern NGRMimeType *const NGRMimeTypeJPG;
extern NGRMimeType *const NGRMimeTypeBMP;

#pragma mark - Video

extern NGRMimeType *const NGRMimeType3gp;
extern NGRMimeType *const NGRMimeTypeAvi;
extern NGRMimeType *const NGRMimeTypeMkv;
extern NGRMimeType *const NGRMimeTypeMP4;
extern NGRMimeType *const NGRMimeTypeMPEG;
extern NGRMimeType *const NGRMimeTypeMov;
extern NGRMimeType *const NGRMimeTypeFlv;
extern NGRMimeType *const NGRMimeTypeWMV;

#pragma mark - Audio

extern NGRMimeType *const NGRMimeTypeWav;
extern NGRMimeType *const NGRMimeTypeMP3;
extern NGRMimeType *const NGRMimeTypeFlac;
extern NGRMimeType *const NGRMimeTypeOgg;
extern NGRMimeType *const NGRMimeTypeM4a;

#pragma mark - Compression

extern NGRMimeType *const NGRMimeTypeTar;
extern NGRMimeType *const NGRMimeTypeZip;
extern NGRMimeType *const NGRMimeTypeRar;
extern NGRMimeType *const NGRMimeType7z;
extern NGRMimeType *const NGRMimeTypeGz;

#pragma mark - Misc

extern NGRMimeType *const NGRMimeTypePDF;
extern NGRMimeType *const NGRMimeTypeUtf8Text;
extern NGRMimeType *const NGRMimeTypeXML;
extern NGRMimeType *const NGRMimeTypeJSON;
