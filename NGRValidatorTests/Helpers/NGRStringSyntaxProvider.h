//
//  NGRStringSyntaxProvider.h
//  NGRValidator
//

#import <Foundation/Foundation.h>

@interface NGRStringSyntaxProvider : NSObject
    
+ (NSString *)email;
+ (NSString *)http;
+ (NSString *)file;
+ (NSString *)name;
+ (NSString *)ipv4;
+ (NSString *)ipv6;
+ (NSString *)domain;
+ (NSString *)uuid;
+ (NSString *)lat;
+ (NSString *)price;
+ (NSString *)ISBN;
+ (NSString *)hexColor;
+ (NSString *)phone;
+ (NSString *)https;
+ (NSString *)postalCode;
+ (NSString *)webSocket;
+ (NSString *)secureWebSocket;
    
@end
