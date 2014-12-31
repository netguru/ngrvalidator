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

@end
