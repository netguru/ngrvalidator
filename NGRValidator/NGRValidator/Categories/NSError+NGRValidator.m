//
//  NSError+NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

#import "NSError+NGRValidator.h"

NSString * const NGRValidatorDomain = @"com.ngr.validator.domain";
NSInteger const NGRValidationInconsistencyCode = 10000;

@implementation NSError (NGRValidator)

+ (instancetype)ngr_errorWithDescription:(NSString *)description {
    return [NSError errorWithDomain:NGRValidatorDomain code:NGRValidationInconsistencyCode userInfo:@{NSLocalizedDescriptionKey : description}];
}

@end
