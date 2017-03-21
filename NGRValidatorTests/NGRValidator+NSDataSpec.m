//
//  NGRValidator+NSDataSpec.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

@interface NGRMimeTypeValidationTestCase : NSObject

@property(nonatomic, strong, readonly) NGRMimeType *mimeType;
@property(nonatomic, strong, readonly) NSData *validData;
@property(nonatomic, strong, readonly) NSData *invalidData;

+ (instancetype)test:(NGRMimeType *)type valid:(NSData *)valid invalid:(NSData *)invalid;

- (NSString *)name;

@end

@implementation NGRMimeTypeValidationTestCase

- (instancetype)initWithMimeType:(NGRMimeType *)type validData:(NSData *)valid invalidData:(NSData *)invalid {
    self = [super init];
    if (self) {
        _mimeType = type;
        _validData = valid;
        _invalidData = invalid;
    }
    return self;
}

+ (instancetype)test:(NGRMimeType *)type valid:(NSData *)valid invalid:(NSData *)invalid {
    return [[self alloc] initWithMimeType:type validData:valid invalidData:invalid];
}

- (NSString *)name {
    NSString *typeName = [[self.mimeType componentsSeparatedByString:@"/"] lastObject];
    return [NSString stringWithFormat:@"Validation of %@", typeName];
}

@end

SpecBegin(NGRValidator_Data)

describe(@"Syntax validation", ^{
    
    // Images
    NSData *png = [NGRDataProvider png];
    NSData *jpg = [NGRDataProvider jpg];
    NSData *pdf = [NGRDataProvider pdf];
    NSData *tiff = [NGRDataProvider tiff];
    NSData *ico = [NGRDataProvider ico];
    NSData *gif = [NGRDataProvider gif];
    
    //Video
    NSData *_3gp = [NGRDataProvider jpg];
    NSData *avi = [NGRDataProvider avi];
    NSData *mkv = [NGRDataProvider mkv];
    NSData *mp4 = [NGRDataProvider mp4];
    NSData *wmv = [NGRDataProvider wmv];
    NSData *flv = [NGRDataProvider flv];
    
    
    NSArray<NGRMimeTypeValidationTestCase *> *testCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeTypePNG valid:png invalid:jpg],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeJPG valid:jpg invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeIco valid:ico invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeTiff valid:tiff invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeGif valid:gif invalid:png],
    ];
    
    for (NGRMimeTypeValidationTestCase *testCase in testCases) {
        testDescriptor(testCase.name, @"valid data", @"invalid data");
        itShouldBehaveLike(NGRValueBehavior, ^{
            return wrapData(testCase.validData, testCase.invalidData, 1, ^(NGRPropertyValidator *validator) {
                return validator.mimeType(testCase.mimeType).msgWrongMIMEType(msg);
            });
        });
    }
    
});

SpecEnd

