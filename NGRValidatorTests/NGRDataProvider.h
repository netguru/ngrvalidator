//
//  NGRDataProvider.h
//  NGRValidator
//
//
//

#import <Foundation/Foundation.h>

typedef NSData*(^LazyNSData)();

@interface NGRTestData : NSObject

@property (nonatomic, strong, readonly) NSArray<NGRMimeType *> *mimeTypes;
@property (nonatomic, copy, readonly) LazyNSData data;

- (instancetype)initWithMimeTypes:(NSArray<NGRMimeType *> *)types data:(LazyNSData)data;
+ (instancetype)testDataWithFile:(NSString *)name extension:(NSString *)ext types:(NSArray<NGRMimeType *> *)types;

@end

@interface NGRDataProvider : NSObject

#pragma mark - Image

+ (NGRTestData *)jpg;
+ (NGRTestData *)png;
+ (NGRTestData *)tiff;
+ (NGRTestData *)ico;
+ (NGRTestData *)gif;
+ (NGRTestData *)bmp;

#pragma mark - Video

+ (NGRTestData *)_3gp;
+ (NGRTestData *)avi;
+ (NGRTestData *)mkv;
+ (NGRTestData *)mp4;
+ (NGRTestData *)wmv;
+ (NGRTestData *)flv;
+ (NGRTestData *)mov;
+ (NGRTestData *)mpeg;

#pragma mark - Misc

+ (NGRTestData *)pdf;
+ (NGRTestData *)xml;
+ (NGRTestData *)json;
+ (NGRTestData *)utf8text;

#pragma mark - Audio

+ (NGRTestData *)wav;
+ (NGRTestData *)m4a;
+ (NGRTestData *)flac;
+ (NGRTestData *)ogg;
+ (NGRTestData *)mp3;

#pragma mark - Compressed

+ (NGRTestData *)gz;
+ (NGRTestData *)zip;
+ (NGRTestData *)tar;
+ (NGRTestData *)rar;
+ (NGRTestData *)_7z;

#pragma mark - Convenience

+ (NSArray <NGRTestData *> *)images;
+ (NSArray <NGRTestData *> *)videos;
+ (NSArray <NGRTestData *> *)audios;
+ (NSArray <NGRTestData *> *)miscs;
+ (NSArray <NGRTestData *> *)archives;
+ (NSArray <NGRTestData *> *)all;


@end
