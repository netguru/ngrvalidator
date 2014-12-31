//
//  NGRDemoCheckboxCell.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import "NGRDemoSwitchCell.h"

@implementation NGRDemoSwitchCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _aSwitch = [[UISwitch alloc] init];
        [self addSubview:_aSwitch];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGSize switchSize = self.aSwitch.frame.size;
    
    self.aSwitch.frame = CGRectMake(CGRectGetWidth(rect) - 10.f - switchSize.width, CGRectGetMidY(rect) - switchSize.height * 0.5f,
                                    switchSize.width, switchSize.height);
    
    self.textLabel.frame = CGRectMake(20.f, 0.f,
                                      CGRectGetMinX(self.aSwitch.frame), CGRectGetHeight(rect));
}

@end
