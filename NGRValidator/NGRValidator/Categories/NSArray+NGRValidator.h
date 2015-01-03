//
//  NSArray+NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (NGRValidator)

- (BOOL)ngr_containsString:(NSString *)string;

- (NSArray *)ngr_sortedArrayByPriority;

@end
