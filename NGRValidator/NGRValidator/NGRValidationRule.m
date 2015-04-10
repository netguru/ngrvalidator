//
//  NGRBlockDescriptor.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import "NGRValidationRule.h"

@implementation NGRValidationRule

- (instancetype)initWithName:(NSString *)name block:(NGRValidationBlock)block {
    self = [super init];
    if (self) {
        _name = name;
        _validationBlock = block;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, name: %@, block: %@>", NSStringFromClass([self class]), self, self.name, self.validationBlock];
}

@end
