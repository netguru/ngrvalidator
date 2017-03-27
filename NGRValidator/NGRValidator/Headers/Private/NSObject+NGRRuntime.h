//
//  NSObject+NGRRuntime.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (NGRRuntime)

NS_ASSUME_NONNULL_BEGIN

- (NSArray *)ngr_propertiesOfClass:(Class)aClass;

- (NSArray *)ngr_properties;

- (nullable Class)ngr_classOfPropertyNamed:(NSString *)propertyName;

NS_ASSUME_NONNULL_END

@end
