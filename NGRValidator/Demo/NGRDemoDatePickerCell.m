//
//  NGRDemoDatePickerCell.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import "NGRDemoDatePickerCell.h"

@implementation NGRDemoDatePickerCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        
        _datePicker = [[UIDatePicker alloc] init];
        [self addSubview:_datePicker];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat marginX = 30.f;
    
    self.textLabel.frame = CGRectMake(20.f, 0.f, CGRectGetWidth(rect) - 20.f, 30.f);
    self.datePicker.frame = CGRectMake(marginX, CGRectGetMaxY(self.textLabel.frame),
                                       CGRectGetWidth(rect) - 2.f * marginX, CGRectGetHeight(rect) - CGRectGetMaxY(self.textLabel.frame));
}

@end
