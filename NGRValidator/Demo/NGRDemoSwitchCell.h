//
//  NGRDemoCheckboxCell.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import <UIKit/UIKit.h>

#define NGRDemoSwitchCellIdentifier @"NGRDemoSwitchCell"

@interface NGRDemoSwitchCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic) UISwitch *aSwitch;

@end
