//
//  NGRStringSyntaxProvider.m
//  NGRValidator
//

#import "NGRStringSyntaxProvider.h"

@implementation NGRStringSyntaxProvider
    
+ (NSString *)email {
    return @"email@domain.international";
}
    
+ (NSString *)http {
    return @"http://www.google.com";
}
    
+ (NSString *)file {
    return @"file://www.test/docs";
}
    
+ (NSString *)name {
    return @"TestNickname";
}
    
+ (NSString *)ipv4 {
    return @"192.168.23.123";
}
    
+ (NSString *)ipv6 {
    return @"2001:0db8:0000:0042:0000:8a2e:0370:7334";
}
    
+ (NSString *)domain {
    return @"google.com";
}
    
+ (NSString *)uuid {
    return @"123e4567-e89b-12d3-a456-426655440000";
}
    
+ (NSString *)lat {
    return @"-23.123";
}
    
+ (NSString *)price {
    return @"23.30";
}
    
+ (NSString *)ISBN {
    return @"978-3-16-148410-0";
}
    
+ (NSString *)hexColor {
    return @"#FF11AA";
}
    
+ (NSString *)phone {
    return @"+48666666666";
}
    
+ (NSString *)https {
    return @"https://www.google.com";
}
    
+ (NSString *)postalCode {
    return @"SW1A 0AA";
}
    
+ (NSString *)webSocket {
    return @"ws://www.google.com";
}
    
+ (NSString *)secureWebSocket {
    return @"wss://www.google.com";
}
    
@end
