//
//  NGRSimpleDemoView.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRSimpleDemoView.h"

@implementation NGRSimpleDemoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textField = [[NGRTextField alloc] init];
        _textField.placeholder = NSLocalizedString(@"Enter e-mail address", nil);
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat margin = 10.f;
    self.textField.frame = CGRectMake(margin,
                                      margin,
                                      CGRectGetWidth(rect) - 2.f * margin,
                                      44.f);
}

@end
