//
//  NGRValidator+NSDataSpec.m
//  NGRValidator
//

SpecBegin(NGRValidator_Data)

describe(@"NSData validation", ^{
    return;
    NGRTestData *png = [NGRTestDataProvider png];
    NGRTestData *mp4 = [NGRTestDataProvider mp4];
    
    testDescriptor(@"Max size", @"data with valid size", @"data with invalid size");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(png.data(), mp4.data(), 1, ^(NGRPropertyValidator *validator) {
            return validator.maxByteSize(8000).msgByteSizeTooBig(msg);
        });
    });
    
    testDescriptor(@"Min size", @"data with valid size", @"data with invalid size");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(mp4.data(), png.data(), 1, ^(NGRPropertyValidator *validator) {
            return validator.minByteSize(8000).msgByteSizeTooSmall(msg);
        });
    });
    
    NSArray<NGRTestData *> *allCases = [NGRTestDataProvider all];

    NSArray<NGRMimeTypeValidationTest *> *imageTestCases = @[
        [NGRMimeTypeValidationTest test:NGRMimeTypePNG withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeJPG withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeIco withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeTiff withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeGif withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeBMP withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTest *> *archiveTestCases = @[
        [NGRMimeTypeValidationTest test:NGRMimeTypeGz  withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeRar withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeZip withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeType7z withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeTar withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTest *> *audioTestCases = @[
        [NGRMimeTypeValidationTest test:NGRMimeTypeMP3 withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeFlac withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeWav withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeM4a withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeOgg withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTest *> *videoTestCases = @[
        [NGRMimeTypeValidationTest test:NGRMimeType3gp withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeAvi withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeMkv withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeMP4 withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeWMV withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeFlv withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeMov withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeMPEG withCases:allCases],
    ];
    
    NSArray<NGRMimeTypeValidationTest *> *miscTestCases = @[
        [NGRMimeTypeValidationTest test:NGRMimeTypeJSON withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeXML withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypeUtf8Text withCases:allCases],
        [NGRMimeTypeValidationTest test:NGRMimeTypePDF withCases:allCases],
    ];
    
    NSArray<NSArray<NGRMimeTypeValidationTest *> *> *allTestCases = @[imageTestCases, videoTestCases, audioTestCases, archiveTestCases, miscTestCases];
    
    for (NSArray<NGRMimeTypeValidationTest *> *testGroup in allTestCases) {
        for (NGRMimeTypeValidationTest *test in testGroup) {
            
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
    
    for (NGRMimeTypeValidationTest *test in imageTestCases) {
        
        NSArray<NGRTestData *> *validCases = [test validCases];
        NGRTestData *invalidData = [NGRTestDataProvider mp3];
        
        for (NGRTestData *validData in validCases) {
            testDescriptor(test.name, @"image data", @"non-image data");
            itShouldBehaveLike(NGRValueBehavior, ^{
                return wrapData(validData.data(), invalidData.data(), 1, ^(NGRPropertyValidator *validator) {
                    return validator.image().msgWrongMediaType(msg);
                });
            });
        }
    }
    
    for (NGRMimeTypeValidationTest *test in videoTestCases) {
        
        NSArray<NGRTestData *> *validCases = [test validCases];
        NGRTestData *invalidData = [NGRTestDataProvider mp3];
        
        for (NGRTestData *validData in validCases) {
            testDescriptor(test.name, @"video data", @"non-video data");
            itShouldBehaveLike(NGRValueBehavior, ^{
                return wrapData(validData.data(), invalidData.data(), 1, ^(NGRPropertyValidator *validator) {
                    return validator.video().msgWrongMediaType(msg);
                });
            });
        }
    }
    
    for (NGRMimeTypeValidationTest *test in audioTestCases) {
        
        NSArray<NGRTestData *> *validCases = [test validCases];
        NGRTestData *invalidData = [NGRTestDataProvider png];
        
        for (NGRTestData *validData in validCases) {
            testDescriptor(test.name, @"audio data", @"non-audio data");
            itShouldBehaveLike(NGRValueBehavior, ^{
                return wrapData(validData.data(), invalidData.data(), 1, ^(NGRPropertyValidator *validator) {
                    return validator.audio().msgWrongMediaType(msg);
                });
            });
        }
    }
    
    for (NGRMimeTypeValidationTest *test in archiveTestCases) {
        
        NSArray<NGRTestData *> *validCases = [test validCases];
        NGRTestData *invalidData = [NGRTestDataProvider mp3];
        
        for (NGRTestData *validData in validCases) {
            testDescriptor(test.name, @"archive data", @"non-archive data");
            itShouldBehaveLike(NGRValueBehavior, ^{
                return wrapData(validData.data(), invalidData.data(), 1, ^(NGRPropertyValidator *validator) {
                    return validator.archive().msgWrongMediaType(msg);
                });
            });
        }
    }
});

SpecEnd

