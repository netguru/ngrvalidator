//
//  NGRDemoCell.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import "NGRDemoTextFieldCell.h"

@implementation NGRDemoTextFieldCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] init];
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = CGRectInset(self.bounds, 20.f, 5.f);
}

@end
