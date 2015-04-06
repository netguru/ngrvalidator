//
//  NSObject+NGRRuntime.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NSObject+NGRRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (NGRRuntime)

#pragma mark - Public

- (NSArray *)ngr_runtimePropertiesOfClass:(Class)aClass {
    
    uint count;
    objc_property_t *properties = class_copyPropertyList(aClass, &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (uint i = 0; i < count ; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    return [propertyArray copy];
}

- (NSArray *)ngr_propertiesOfClass:(Class)aClass {
    
    NSMutableArray *array = [[self ngr_runtimePropertiesOfClass:aClass] mutableCopy];
    if (aClass.superclass != [NSObject class]) {
        [array addObjectsFromArray:[self ngr_propertiesOfClass:aClass.superclass]];
    }
    return [array copy];
}

- (NSArray *)ngr_properties {
    return [self ngr_propertiesOfClass:[self class]];
}

- (Class)ngr_classOfPropertyNamed:(NSString *)propertyName {
    
    Class propertyClass = nil;
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    if (splitPropertyAttributes.count > 0) {
        NSString *encodeType = splitPropertyAttributes[0];
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        NSString *className = splitEncodeType.count > 1 ? splitEncodeType[1] : splitEncodeType[0];
        propertyClass = NSClassFromString(className);
    }
    return propertyClass;
}

@end
