//
//  NGRValidator+NSDataSpec.m
//  NGRValidator
//
//
//

SpecBegin(NGRValidator_Data)

describe(@"Syntax validation", ^{
    
    NSArray<NGRTestData *> *allCases = [NGRDataProvider all];

    NSArray<NGRMimeTypeValidationTestCase *> *imageTestCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeTypePNG withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeJPG withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeIco withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeTiff withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeGif withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeBMP withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTestCase *> *archiveTestCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeGz  withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeRar withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeZip withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeType7z withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeTar withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTestCase *> *audioTestCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeMP3 withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeFlac withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeWav withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeM4a withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeOgg withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTestCase *> *videoTestCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeType3gp withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeAvi withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeMkv withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeMP4 withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeWMV withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeFlv withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeMov withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeMPEG withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTestCase *> *miscTestCases = @[
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeJSON withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeXML withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypeUtf8Text withCases:allCases],
        [NGRMimeTypeValidationTestCase test:NGRMimeTypePDF withCases:allCases],
    ];
    
    NSArray<NSArray<NGRMimeTypeValidationTestCase *> *> *allTestCases = @[imageTestCases, videoTestCases, audioTestCases, archiveTestCases, miscTestCases];
    
    for (NSArray<NGRMimeTypeValidationTestCase *> *testGroup in allTestCases) {
        for (NGRMimeTypeValidationTestCase *test in testGroup) {
            
            NSArray<NGRTestData *> *validCases = [test validCases];
            NSArray<NGRTestData *> *invalidCases = [test invalidCases];
            
            for (NGRTestData *validData in validCases) {
                for (NGRTestData *invalidData in invalidCases) {
                
                    testDescriptor(test.name, validData.mimeTypes.firstObject, invalidData.mimeTypes.firstObject);
                    itShouldBehaveLike(NGRValueBehavior, ^{
                        return wrapData(validData.data(), invalidData.data(), 1, ^(NGRPropertyValidator *validator) {
                            return validator.mimeType(test.mimeType).msgWrongMIMEType(msg);
                        });
                    });
                }
            }
            
            
        }
    }
//    }
//    
//    for (NGRMimeTypeValidationTestCase *testCase in imageTestCases) {
//        testDescriptor(testCase.name, @"image data", @"non-image data");
//        itShouldBehaveLike(NGRValueBehavior, ^{
//            return wrapData(testCase.validData(), testCase.invalidData(), 1, ^(NGRPropertyValidator *validator) {
//                return validator.image().msgWrongMediaType(msg);
//            });
//        });
//    }
//    
//    for (NGRMimeTypeValidationTestCase *testCase in videoTestCases) {
//        testDescriptor(testCase.name, @"video data", @"non-video data");
//        itShouldBehaveLike(NGRValueBehavior, ^{
//            return wrapData(testCase.validData(), testCase.invalidData(), 1, ^(NGRPropertyValidator *validator) {
//                return validator.video().msgWrongMediaType(msg);
//            });
//        });
//    }
//    
//    for (NGRMimeTypeValidationTestCase *testCase in audioTestCases) {
//        testDescriptor(testCase.name, @"audio data", @"non-audio data");
//        itShouldBehaveLike(NGRValueBehavior, ^{
//            return wrapData(testCase.validData(), testCase.invalidData(), 1, ^(NGRPropertyValidator *validator) {
//                return validator.audio().msgWrongMediaType(msg);
//            });
//        });
//    }
//    
//    for (NGRMimeTypeValidationTestCase *testCase in archiveTestCases) {
//        testDescriptor(testCase.name, @"archive data", @"non-archive data");
//        itShouldBehaveLike(NGRValueBehavior, ^{
//            return wrapData(testCase.validData(), testCase.invalidData(), 1, ^(NGRPropertyValidator *validator) {
//                return validator.archive().msgWrongMediaType(msg);
//            });
//        });
//    }
    
});

SpecEnd

