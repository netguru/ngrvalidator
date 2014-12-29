//
//  CalendarEvent.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 29.12.2014.
//
//

#import "CalendarEvent.h"
#import "NGRValidator.h"

@implementation CalendarEvent

- (NSError *)validate {
    
    NSError *error = nil;
    BOOL success = [NGRValidator validateModel:self error:&error usingRules:^NSArray *{
        return @[NGRValidate(@"title").required().minLength(6).msgTooShort(@"should has at least 6 signs"),
                 NGRValidate(@"creatorLastName").required().lengthRange(4, 30).syntax(NGRSyntaxName).localizedName(@"Lastname").msgTooShort(@"should has at least 4 signs").msgTooLong(@"should has at most 30 signs."),
                 NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"url").syntax(NGRSyntaxURL),
                 NGRValidate(@"startDate").required().laterThanOrEqualTo([NSDate date]).earlierThan(self.endDate).localizedName(@"Event start date").msgNotLaterThanOrEqualTo(@"cannot be earlier than now.").msgNotEarlierThan(@"cannot be later than it's end."),
                 NGRValidate(@"endDate").required().laterThan(self.startDate).localizedName(@"Event end date").msgNotLaterThan(@"cannot be earlier than it's start"),
                 NGRValidate(@"termsOfUse").required().trueValue().msgNotTrue(@"You have to accept terms of use")];
    }];
    
    success ? NSLog(@"Event validation succeed") : NSLog(@"Event validation failed because of an error: %@", error.localizedDescription);
    return error;
}

/**
 *  For demo purposes:
 *  To all setters method [self validate] has been added, to make easier to show validation process in demo app.
 */

- (void)setTitle:(NSString *)title {
    _title = title;
    [self validate];
}

- (void)setCreatorLastName:(NSString *)creatorLastName {
    _creatorLastName = creatorLastName;
    [self validate];
}

- (void)setEmail:(NSString *)email {
    _email = email;
    [self validate];
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [self validate];
}

- (void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    [self validate];
}

- (void)setEndDate:(NSDate *)endDate {
    _endDate = endDate;
    [self validate];
}

- (void)setTermsOfUse:(BOOL)termsOfUse {
    _termsOfUse = termsOfUse;
    [self validate];
}

@end
