//
//  NGRDataProvider.m
//  NGRValidator
//
//
//

#import "NGRDataProvider.h"

@implementation NGRTestData

- (instancetype)initWithMimeTypes:(NSArray<NGRMimeType *> *)types data:(LazyNSData)data {
    self = [super init];
    if (self) {
        _mimeTypes = types;
        _data = data;
    }
    return self;
}

+ (instancetype)testDataWithFile:(NSString *)name extension:(NSString *)ext types:(NSArray<NGRMimeType *> *)types {
    NSBundle *bundle = [NSBundle bundleForClass:self];
    
    return [[self alloc] initWithMimeTypes:types data:^{
        NSURL *url = [bundle URLForResource:name withExtension:ext];
        return [NSData dataWithContentsOfURL:url];
    }];
}

@end

@implementation NGRDataProvider

#pragma mark - Image

+ (NGRTestData *)jpg {
    return [self loadFile:@"logo" extension:@"jpg" types:@[NGRMimeTypeJPG]];
}

+ (NGRTestData *)png {
    return [self loadFile:@"logo" extension:@"png" types:@[NGRMimeTypePNG]];
}

+ (NGRTestData *)tiff {
    return [self loadFile:@"logo" extension:@"tiff" types:@[NGRMimeTypeTiff]];
}

+ (NGRTestData *)ico {
    return [self loadFile:@"logo" extension:@"ico" types:@[NGRMimeTypeIco]];
}

+ (NGRTestData *)gif {
    return [self loadFile:@"logo" extension:@"gif" types:@[NGRMimeTypeGif]];
}

+ (NGRTestData *)bmp {
    return [self loadFile:@"logo" extension:@"bmp" types:@[NGRMimeTypeBMP]];
}

#pragma mark - Video

+ (NGRTestData *)_3gp {
    return [self loadFile:@"logo" extension:@"3gp" types:@[NGRMimeType3gp]];
}

+ (NGRTestData *)avi {
    return [self loadFile:@"logo" extension:@"avi" types:@[NGRMimeTypeAvi]];
}

+ (NGRTestData *)mkv {
    return [self loadFile:@"logo" extension:@"mkv" types:@[NGRMimeTypeMkv]];
}

+ (NGRTestData *)mp4 {
    return [self loadFile:@"logo" extension:@"mp4" types:@[NGRMimeTypeMP4]];
}

+ (NGRTestData *)wmv {
    return [self loadFile:@"logo" extension:@"wmv" types:@[NGRMimeTypeWMV]];
}

+ (NGRTestData *)flv {
    return [self loadFile:@"logo" extension:@"flv" types:@[NGRMimeTypeFlv]];
}

+ (NGRTestData *)mov {
    return [self loadFile:@"logo" extension:@"mov" types:@[NGRMimeTypeMov]];
}

+ (NGRTestData *)mpeg {
    return [self loadFile:@"logo" extension:@"mpg" types:@[NGRMimeTypeMPEG]];
}

#pragma mark - Misc

+ (NGRTestData *)pdf {
    return [self loadFile:@"logo" extension:@"pdf" types:@[NGRMimeTypePDF]];
}

+ (NGRTestData *)xml {
    return [self loadFile:@"logo" extension:@"xml" types:@[NGRMimeTypeXML, NGRMimeTypeUtf8Text]];
}

+ (NGRTestData *)json {
    return [self loadFile:@"logo" extension:@"json" types:@[NGRMimeTypeJSON, NGRMimeTypeUtf8Text]];
}

+ (NGRTestData *)utf8text {
    return [[NGRTestData alloc] initWithMimeTypes:@[NGRMimeTypeUtf8Text] data:^{
        return [@"logo" dataUsingEncoding:NSUTF8StringEncoding];
    }];
}

#pragma mark - Audio

+ (NGRTestData *)wav {
    return [self loadFile:@"logo" extension:@"wav" types:@[NGRMimeTypeWav]];
}

+ (NGRTestData *)m4a {
    return [self loadFile:@"logo" extension:@"m4a" types:@[NGRMimeTypeM4a]];
}

+ (NGRTestData *)flac {
    return [self loadFile:@"logo" extension:@"flac" types:@[NGRMimeTypeFlac]];
}

+ (NGRTestData *)ogg {
    return [self loadFile:@"logo" extension:@"ogg" types:@[NGRMimeTypeOgg]];
}

+ (NGRTestData *)mp3 {
    return [self loadFile:@"logo" extension:@"mp3" types:@[NGRMimeTypeMP3]];
}

#pragma mark - Compressed

+ (NGRTestData *)gz {
    return [self loadFile:@"logo" extension:@"tgz" types:@[NGRMimeTypeGz]];
}

+ (NGRTestData *)zip {
    return [self loadFile:@"logo" extension:@"zip" types:@[NGRMimeTypeZip]];
}

+ (NGRTestData *)tar {
    return [self loadFile:@"logo" extension:@"tar" types:@[NGRMimeTypeTar]];
}

+ (NGRTestData *)rar {
    return [self loadFile:@"logo" extension:@"rar" types:@[NGRMimeTypeRar]];
}

+ (NGRTestData *)_7z {
    return [self loadFile:@"logo" extension:@"7z" types:@[NGRMimeType7z]];
}

#pragma mark - Convenience 

+ (NSArray <NGRTestData *> *)images {
    NGRTestData *png = [self png];
    NGRTestData *jpg = [self jpg];
    NGRTestData *tiff = [self tiff];
    NGRTestData *ico = [self ico];
    NGRTestData *gif = [self gif];
    NGRTestData *bmp = [self bmp];
    
    return @[png, jpg, tiff, ico, gif, bmp];
}

+ (NSArray <NGRTestData *> *)videos {
    NGRTestData *_3gp = [self _3gp];
    NGRTestData *avi = [self avi];
    NGRTestData *mkv = [self mkv];
    NGRTestData *mp4 = [self mp4];
    NGRTestData *wmv = [self wmv];
    NGRTestData *flv = [self flv];
    NGRTestData *mov = [self mov];
    NGRTestData *mpeg = [self mpeg];
    
    return @[_3gp, avi, mkv, mp4, wmv, flv, mov, mpeg];
}

+ (NSArray <NGRTestData *> *)audios {
    NGRTestData *mp3 = [self mp3];
    NGRTestData *flac = [self flac];
    NGRTestData *wav = [self wav];
    NGRTestData *m4a = [self m4a];
    NGRTestData *ogg = [self ogg];
    
    return @[mp3, flac, wav, m4a, ogg];
}

+ (NSArray <NGRTestData *> *)miscs {
    NGRTestData *pdf = [self pdf];
    NGRTestData *json = [self json];
    NGRTestData *xml = [self xml];
    NGRTestData *utf8text = [self utf8text];
    
    return @[pdf, json, xml, utf8text];
}

+ (NSArray <NGRTestData *> *)archives {
    NGRTestData *zip = [self zip];
    NGRTestData *rar = [self rar];
    NGRTestData *gz = [self gz];
    NGRTestData *tar = [self tar];
    NGRTestData *_7z = [self _7z];
    
    return @[zip, rar, gz ,tar, _7z];
}

+ (NSArray <NGRTestData *> *)all {
    NSArray<NGRTestData *> *images = [self images];
    NSArray<NGRTestData *> *videos = [self videos];
    NSArray<NGRTestData *> *audios = [self audios];
    NSArray<NGRTestData *> *miscs = [self miscs];
    NSArray<NGRTestData *> *archives = [self archives];
    
    NSArray *categories = @[images, videos, audios, miscs, archives];
    
    NSMutableArray<NGRTestData *> *all = [NSMutableArray new];
    for (NSArray<NGRTestData *> *category in categories) {
        for (NGRTestData *testData in category) {
            [all addObject:testData];
        }
    }
    
    return [all copy];
}

#pragma mark - Private

+ (NGRTestData *)loadFile:(NSString *)name extension:(NSString *)ext types:(NSArray <NGRMimeType *> *)types {
    return [NGRTestData testDataWithFile:name extension:ext types:types];
}

@end
