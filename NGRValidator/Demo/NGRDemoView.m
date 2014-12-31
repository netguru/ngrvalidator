//
//  NGRView.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import "NGRDemoView.h"

@implementation NGRDemoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = CGRectMake(0.f, 0.f,
                             CGRectGetWidth(self.bounds),
                             CGRectGetHeight(self.bounds) - self.keyboardHeight);
    self.tableView.frame = rect;
}

@end
