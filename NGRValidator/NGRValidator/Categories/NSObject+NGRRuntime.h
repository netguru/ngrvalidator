//
//  NSObject+NGRRuntime.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (NGRRuntime)

- (nonnull NSArray *)ngr_propertiesOfClass:(nonnull Class)aClass;

- (nonnull NSArray *)ngr_properties;

- (nullable Class)ngr_classOfPropertyNamed:(nonnull NSString *)propertyName;

@end
