//
//  NSString+NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSString (NGRValidator)

NS_ASSUME_NONNULL_BEGIN

- (BOOL)ngr_isEmail;

- (BOOL)ngr_isURL;

- (BOOL)ngr_isName;

- (BOOL)ngr_isDecimal;

- (NSString *)ngr_stringByCapitalizeFirstLetter;

- (BOOL)ngr_hasEmoji;

- (BOOL)ngr_isValidCreditCardNumber;

- (BOOL)ngr_isValidCreditCardExpirationDate;

NS_ASSUME_NONNULL_END

@end
