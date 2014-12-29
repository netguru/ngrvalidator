//
//  AppDelegate.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "AppDelegate.h"
#import "NGRTestModel.h"
#import "NGRValidator.h"

@interface AppDelegate ()

@end

@interface CalendarEvent : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *creatorLastName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end

@implementation CalendarEvent
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NGRTestModel *model = [[NGRTestModel alloc] init];
    //    model.name = @"my_custom_name";
    model.email = @"email@example.com";
    model.number = @10;
    model.aFloat = 12.0f;
    model.aBool = NO;
    model.date = [NSDate date];
    
    NSError *error = nil;
    
    CalendarEvent *event = [[CalendarEvent alloc] init];
    
    event.title = @"sf";
    
    NSArray * array = [NGRValidator validateModel:event usingRules:^NSArray *{
        return @[NGRValidate(@"title").required().minLength(5).msgTooLong(@"should has at least 5 signs"),
                 NGRValidate(@"creatorLastName").required().lengthRange(4, 30).syntax(NGRSyntaxName).localizedName(@"Lastname").msgTooShort(@"should has at least 4 signs").msgTooLong(@"should has at most 30 signs.").msgWrongSyntax(NGRSyntaxName, @"has to contain digits only."),
                 NGRValidate(@"email").required().syntax(NGRSyntaxEmail),
                 NGRValidate(@"url").syntax(NGRSyntaxURL),
                 NGRValidate(@"startDate").required().laterThanOrEqualTo([NSDate date]).earlierThan(event.endDate).localizedName(@"Event start date").msgNotLaterThanOrEqualTo(@"cannot be earlier than now.").msgNotEarlierThan(@"cannot be later than it's end."),
                 NGRValidate(@"endDate").required().laterThan(event.startDate).localizedName(@"Event end date").msgNotLaterThan(@"cannot be earlier than it's start")];
    }];

    for (NSError *error in array) {
            NSLog(@"%@", error.localizedDescription);
    }
    
    return YES;
}


@end
