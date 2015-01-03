//
//  NSObject+NGRRuntime.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (NGRRuntime)

- (NSArray *)ngr_propertiesOfClass:(Class)aClass;

- (NSArray *)ngr_properties;

- (Class)ngr_classOfPropertyNamed:(NSString *)propertyName;

@end
