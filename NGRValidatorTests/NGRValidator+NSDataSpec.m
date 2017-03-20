//
//  NGRValidator+NSDataSpec.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

SpecBegin(NGRValidator_Data)

describe(@"Syntax validation", ^{
    
    NSData *png = [NGRDataProvider png];
    NSData *jpg = [NGRDataProvider jpg];
    
    testDescriptor(@"data validation", @"png data", @"not png data");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(png, jpg, 1, ^(NGRPropertyValidator *validator) {
            return validator.mimeType(NGRMimeTypePNG).msgWrongMIMEType(msg);
        });
    });

});

SpecEnd

