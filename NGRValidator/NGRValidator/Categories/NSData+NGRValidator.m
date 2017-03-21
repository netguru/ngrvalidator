//
//  NSData+NGRValidator.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 20.03.2017.
//
//

#import "NSData+NGRValidator.h"
#import "NGRMimeTypeValidator.h"

@implementation NSData (NGRValidator)

- (BOOL)ngr_hasMimeType:(NGRMimeType *)type {

    NGRMimeTypeValidator *validator = [NGRMimeTypeValidator validatorForMimeType:type];
    
    NSAssert(validator != nil, @"Detection not supported for this type");

    return validator.isValid(self);
}

@end
