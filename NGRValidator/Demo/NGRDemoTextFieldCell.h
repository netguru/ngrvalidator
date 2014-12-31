//
//  NGRDemoCell.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import <UIKit/UIKit.h>

#define NGRDemoTextFieldCellIdentifier @"NGRDemoTextFieldCell"

@interface NGRDemoTextFieldCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic) UITextField *textField;

@end
