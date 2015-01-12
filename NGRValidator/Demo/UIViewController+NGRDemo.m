//
//  UIViewController+NGRDemo.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 12.01.2015.
//
//

#import "UIViewController+NGRDemo.h"

@implementation UIViewController (NGRDemo)

- (void)showAlertViewWithError:(NSError *)error {
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
