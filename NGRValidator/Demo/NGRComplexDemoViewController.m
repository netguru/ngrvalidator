//
//  NGRViewController.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import "NGRComplexDemoViewController.h"
#import "NGRComplexDemoView.h"

#import "UIViewController+NGRDemo.h"

#import "NGRDemoTextFieldCell.h"
#import "NGRDemoDatePickerCell.h"
#import "NGRDemoSwitchCell.h"

#import "NGRCalendarEvent.h"

#define kTitleRow       0
#define kLastnameRow    1
#define kEmailRow       2
#define kURLRow         3
#define kTermsOfUseRow  4
#define kStartDateRow   5
#define kEndDateRow     6
#define kNumberOfRows   7

@interface NGRComplexDemoViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) NGRComplexDemoView *aView;
@property (strong, nonatomic) NGRCalendarEvent *event;

@end

@implementation NGRComplexDemoViewController

#pragma mark - View Lifecycle Methods

- (void)loadView {
    NGRComplexDemoView *view = [[NGRComplexDemoView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.view = view;
    
    _aView = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Create event", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Validate!", nil) style:UIBarButtonItemStylePlain target:self action:@selector(validateBarButtonDidClick:)];
    
    self.aView.tableView.delegate = self;
    self.aView.tableView.dataSource = self;
    [self registerKeyboardNotifications];
    _event = [[NGRCalendarEvent alloc] initWithDefaultDates];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case kTitleRow:
        case kLastnameRow:
        case kEmailRow:
        case kURLRow:
            return [self tableView:tableView textFieldCellForRowAtIndexPath:indexPath identifier:NGRDemoTextFieldCellIdentifier];
        case kStartDateRow:
        case kEndDateRow:
            return [self tableView:tableView datePickerCellForRowAtIndexPath:indexPath identifier:NGRDemoDatePickerCellIdentifier];
        case kTermsOfUseRow:
            return [self tableView:tableView checkboxCellForRowAtIndexPath:indexPath identifier:NGRDemoSwitchCellIdentifier];
            
        default: //never reach here
            return nil;
    }
}

- (NGRDemoTextFieldCell *)tableView:(UITableView *)tableView textFieldCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier {
    
    NGRDemoTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NGRDemoTextFieldCell alloc] initWithReuseIdentifier:identifier];
        cell.textField.delegate = self;
    }
    
    cell.textField.tag = indexPath.row;
    
    switch (indexPath.row) {
        case kTitleRow:
            cell.textField.placeholder = NSLocalizedString(@"Event title (required)", nil);
            cell.textField.text = self.event.title;
            break;
        case kLastnameRow:
            cell.textField.placeholder = NSLocalizedString(@"Event owner lastname (required)", nil);
            cell.textField.text = self.event.creatorLastName;
            break;
        case kEmailRow:
            cell.textField.placeholder = NSLocalizedString(@"Event owner email (required)", nil);
            cell.textField.text = self.event.email;
            break;
        case kURLRow:
            cell.textField.placeholder = NSLocalizedString(@"Event url", nil);
            cell.textField.text = self.event.url;
            break;
        default:
            break;
    }
 
    return cell;
}

- (NGRDemoSwitchCell *)tableView:(UITableView *)tableView checkboxCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier {
    
    NGRDemoSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NGRDemoSwitchCell alloc] initWithReuseIdentifier:identifier];
        cell.textLabel.text = NSLocalizedString(@"I accept terms of use", nil);
        [cell.aSwitch addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    cell.aSwitch.on = self.event.termsOfUse;
    return cell;
}

- (NGRDemoDatePickerCell *)tableView:(UITableView *)tableView datePickerCellForRowAtIndexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier {
    
    NGRDemoDatePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NGRDemoDatePickerCell alloc] initWithReuseIdentifier:identifier];
        [cell.datePicker addTarget:self action:@selector(datePickerDidChangeDate:) forControlEvents:UIControlEventValueChanged];
    }
    
    cell.datePicker.tag = indexPath.row;
    
    switch (indexPath.row) {
        case kStartDateRow:
            cell.textLabel.text = NSLocalizedString(@"Event start date:", nil);
            cell.datePicker.date = self.event.startDate;
            break;
            
            case kEndDateRow:
            cell.textLabel.text = NSLocalizedString(@"Event end date:", nil);
            cell.datePicker.date = self.event.endDate;
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self isDatePickerCellAtIndePath:indexPath] ? 210.0f : 44.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UIControl Methods

- (void)validateBarButtonDidClick:(UIBarButtonItem *)button {
    NSError *error = [self.event validate];
    [self showAlertViewWithError:error];
}

- (void)datePickerDidChangeDate:(UIDatePicker *)picker {
    switch (picker.tag) {
        case kStartDateRow:
            self.event.startDate = picker.date;
            break;
        case kEndDateRow:
            self.event.endDate = picker.date;
            break;
            
        default:
            break;
    }
}

- (void)switchValueDidChange:(UISwitch *)aSwitch {
    self.event.termsOfUse = aSwitch.isOn;
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.aView endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self textField:textField textDidChangeToText:nil];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *mutableText = [textField.text mutableCopy];
    [mutableText replaceCharactersInRange:range withString:string];
    [self textField:textField textDidChangeToText:[mutableText copy]];
    return YES;
}

#pragma mark - NSNotificationCenter Methods

- (void)keyboardDidAppear:(NSNotification *)notification {
    self.aView.keyboardHeight = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self.aView setNeedsLayout];
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    self.aView.keyboardHeight = 0.f;
    [self.aView setNeedsLayout];
}

#pragma mark - Private

- (BOOL)isDatePickerCellAtIndePath:(NSIndexPath *)indexPath {
    return (indexPath.row == kStartDateRow || indexPath.row == kEndDateRow);
}

- (void)textField:(UITextField *)textField textDidChangeToText:(NSString *)text {
    
    switch (textField.tag) {
        case kTitleRow:
            self.event.title = text;
            break;
        case kLastnameRow:
            self.event.creatorLastName = text;
            break;
        case kEmailRow:
            self.event.email = text;
            break;
        case kURLRow:
            self.event.url = text;
            break;
            
        default:
            break;
    }
}

- (void)registerKeyboardNotifications {

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

@end
