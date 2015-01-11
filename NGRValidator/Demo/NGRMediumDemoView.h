//
//  NGRMediumDemoView.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import <UIKit/UIKit.h>
#import "NGRTextField.h"

@interface NGRMediumDemoView : UIView

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NGRTextField *passwordTextField;
@property (strong, nonatomic) NGRTextField *repeatedPasswordTextField;

@end
