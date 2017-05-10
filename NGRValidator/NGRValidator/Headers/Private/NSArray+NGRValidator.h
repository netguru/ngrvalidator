//
//  NSArray+NGRValidator.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (NGRValidator)

NS_ASSUME_NONNULL_BEGIN

- (BOOL)ngr_containsString:(NSString *)string;

- (NSArray *)ngr_sortedArrayByPriority;

NS_ASSUME_NONNULL_END

@end
