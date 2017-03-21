//
//  NGRValidator+NSDataSpec.m
//  NGRValidator
//
//
//

SpecBegin(NGRValidator_Data)

describe(@"Syntax validation", ^{
    
    // Images
    NSData *png = [NGRDataProvider png];
    NSData *jpg = [NGRDataProvider jpg];
    NSData *tiff = [NGRDataProvider tiff];
    NSData *ico = [NGRDataProvider ico];
    NSData *gif = [NGRDataProvider gif];
    NSData *bmp = [NGRDataProvider bmp];
    
    //Video
    NSData *_3gp = [NGRDataProvider jpg];
    NSData *avi = [NGRDataProvider avi];
    NSData *mkv = [NGRDataProvider mkv];
    NSData *mp4 = [NGRDataProvider mp4];
    NSData *wmv = [NGRDataProvider wmv];
    NSData *flv = [NGRDataProvider flv];
    
    //Misc
    NSData *pdf = [NGRDataProvider pdf];
    
    
    NSArray<NGRMimeTypeValidationTestCase *> *testCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeTypePNG valid:png invalid:jpg],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeJPG valid:jpg invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeIco valid:ico invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeTiff valid:tiff invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeGif valid:gif invalid:png],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeBMP valid:bmp invalid:png],
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

