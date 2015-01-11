//
//  NGRTextField.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRTextField.h"

@implementation NGRTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}

@end
