//
//  NSError+NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

#import <Foundation/Foundation.h>

extern NSString * const NGRValidatorDomain;

extern NSString * const NGRValidatorPropertyNameKey;

@interface NSError (NGRValidator)

+ (instancetype)ngr_errorWithDescription:(NSString *)description propertyName:(NSString *)propertyName;

@end
