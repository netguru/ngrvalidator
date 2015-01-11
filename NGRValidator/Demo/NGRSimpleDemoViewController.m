//
//  NGRSimpleDemoViewController.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRSimpleDemoViewController.h"
#import "NGRSimpleDemoView.h"
#import "NGRValidator.h"

@interface NGRSimpleDemoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) NGRSimpleDemoView *aView;

@end

@implementation NGRSimpleDemoViewController

#pragma mark - View Lifecycle Methods

- (void)loadView {
    [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight];
    NGRSimpleDemoView *view = [[NGRSimpleDemoView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.view = view;
    
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Just an email", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Validate!", nil) style:UIBarButtonItemStylePlain target:self action:@selector(validateBarButtonDidClick:)];
    
    self.aView.textField.delegate = self;
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(NGRTextField *)textField {
    [self.aView endEditing:YES];
    return YES;
}

#pragma mark - UIControl Methods

- (void)validateBarButtonDidClick:(UIBarButtonItem *)button {
    
    NSError *error = [NGRValidator validateValue:self.aView.textField.text named:NSLocalizedString(@"E-mail address", nil) usingRules:^(NGRPropertyValidator *validator) {
        validator.required().syntax(NGRSyntaxEmail);
    }];
    if (error) {
        [self showAlertViewWithTitle:NSLocalizedString(@"Validation failed!", nil) message:error.localizedDescription];
    } else {
        [self showAlertViewWithTitle:NSLocalizedString(@"Validation succeed!", nil) message:NSLocalizedString(@"Now you can do with your event whatever you want, cause you are sure your event passed validation. High five!", nil)];
    }
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] show];
}

@end

