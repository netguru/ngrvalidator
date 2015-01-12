//
//  NSString+NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSString (NGRValidator)

- (BOOL)ngr_isEmail;

- (BOOL)ngr_isURL;

- (BOOL)ngr_isName;

- (BOOL)ngr_isDecimal;

- (NSString *)ngr_stringByCapitalizeFirstLetter;

@end
