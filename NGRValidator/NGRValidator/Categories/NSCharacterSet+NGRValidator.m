//
//  NSCharacterSet+NGRValidator.m
//  NGRValidator
//
//
//

#import "NSCharacterSet+NGRValidator.h"

@implementation NSCharacterSet (NGRValidator)

+ (NSCharacterSet *)emojisCharacterSet {
    NSString *emojis = @"🙂";
    
    return [NSCharacterSet characterSetWithCharactersInString:emojis];
}

@end
