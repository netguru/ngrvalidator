//
//  NGRDemoDatePickerCell.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import <UIKit/UIKit.h>

#define NGRDemoDatePickerCellIdentifier @"NGRDemoDatePickerCell"

@interface NGRDemoDatePickerCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic, readonly) UIDatePicker *datePicker;

@end
