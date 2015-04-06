//
//  NGRTestModel.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 06/04/15.
//
//

#import "NGRTestModel.h"

@implementation NGRTestModel

- (instancetype)initWithValue:(id)value secondValue:(id)secondValue {
    self = [super init];
    if (self) {
        _value = value;
        _secondValue = secondValue;
    }
    return self;
}

@end
