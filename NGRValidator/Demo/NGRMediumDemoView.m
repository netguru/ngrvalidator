//
//  NGRMediumDemoView.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRMediumDemoView.h"

@implementation NGRMediumDemoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Scenario: sign in", @"Scenario: change pass"]];
        _segmentedControl.selectedSegmentIndex = 0;
        [self addSubview:_segmentedControl];
        
        _passwordTextField = [[NGRTextField alloc] init];
        _passwordTextField.placeholder = NSLocalizedString(@"Password", nil);
        [self addSubview:_passwordTextField];
        
        _repeatedPasswordTextField = [[NGRTextField alloc] init];
        _repeatedPasswordTextField.placeholder = NSLocalizedString(@"Repeated Password", nil);
        [self addSubview:_repeatedPasswordTextField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = [self isLandscape] ? 33.f : 44.f;
    
    self.segmentedControl.frame = [self frameAtMinYStartPoint:0.f height:30.f];
    self.passwordTextField.frame = [self frameAtMinYStartPoint:CGRectGetMaxY(self.segmentedControl.frame) height:height];
    self.repeatedPasswordTextField.frame = [self frameAtMinYStartPoint:CGRectGetMaxY(self.passwordTextField.frame) height:height];
}

- (CGRect)frameAtMinYStartPoint:(CGFloat)y height:(CGFloat)height {
    
    CGRect rect = self.bounds;
    CGFloat margin = [self isLandscape] ? 6.f : 10.f;
    return CGRectMake(margin,
                      y + margin,
                      CGRectGetWidth(rect) - 2.f * margin,
                      height);

}

- (BOOL)isLandscape {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

@end
