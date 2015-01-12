//
//  NGRMediumDemoViewController.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRMediumDemoViewController.h"
#import "NGRMediumDemoView.h"
#import "UIViewController+NGRDemo.h"
#import "NGRUser.h"

@interface NGRMediumDemoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) NGRMediumDemoView *aView;
@property (strong, nonatomic) NGRUser *user;
@end

@implementation NGRMediumDemoViewController

#pragma mark - View Lifecycle Methods

- (void)loadView {
    [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight];
    NGRMediumDemoView *view = [[NGRMediumDemoView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.view = view;
    
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"User account", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Validate!", nil) style:UIBarButtonItemStylePlain target:self action:@selector(validateBarButtonDidClick:)];
    
    self.aView.passwordTextField.delegate = self;
    self.aView.repeatedPasswordTextField.delegate = self;
    
    _user = [[NGRUser alloc] init];
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(NGRTextField *)textField {
    [self.aView endEditing:YES];
    return YES;
}

#pragma mark - UIControl Methods

- (void)validateBarButtonDidClick:(UIBarButtonItem *)button {
    
    self.user.password = self.aView.passwordTextField.text;
    self.user.repeatedPassword = self.aView.repeatedPasswordTextField.text;
    
    NGRUserScenario scenario = (self.aView.segmentedControl.selectedSegmentIndex == 0) ? NGRUserScenarioSignIn : NGRUserScenarioPasswordChange;
    NSError *error = [self.user validateWithScenario:scenario];
    [self showAlertViewWithError:error];
}

@end
