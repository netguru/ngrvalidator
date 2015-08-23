//
//  AppDelegate.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "AppDelegate.h"
#import "NGRCalendarEvent.h"

#import "NGRSimpleDemoViewController.h"
#import "NGRMediumDemoViewController.h"
#import "NGRComplexDemoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL logStory = NO; //change to YES if you want to log story
    if (logStory) {
        [self story];
    }
    
    NGRSimpleDemoViewController *simpleDemoViewController = [[NGRSimpleDemoViewController alloc] init];
    UINavigationController *simpleNavigationController = [[UINavigationController alloc] initWithRootViewController:simpleDemoViewController];
    
    NGRMediumDemoViewController *mediumDemoViewController = [[NGRMediumDemoViewController alloc] init];
    UINavigationController *mediumNavigationController = [[UINavigationController alloc] initWithRootViewController:mediumDemoViewController];
    
    NGRComplexDemoViewController *complexDemoViewController = [[NGRComplexDemoViewController alloc] init];
    UINavigationController *complexNavigationController = [[UINavigationController alloc] initWithRootViewController:complexDemoViewController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[simpleNavigationController, mediumNavigationController, complexNavigationController];
    
    [tabBarController.tabBar.items[0] setTitle:NSLocalizedString(@"Simple", nil)];
    [tabBarController.tabBar.items[1] setTitle:NSLocalizedString(@"Medium", nil)];
    [tabBarController.tabBar.items[2] setTitle:NSLocalizedString(@"Complex", nil)];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

/**
 *  It's recommended to set breakpoint at event object initializing to improve readability of log statements
 */
- (void)story {
    NGRCalendarEvent *event = [[NGRCalendarEvent alloc] init];
    event.enableImmediatelyValidation = YES;
    
    //Let's start validation story! First property (title) given in 'usingRules' block will be validated:
    NSLog(@"[1]:");
    [event validate];
    
    //Ups...Title is required. Make it just "Event" then:
    NSLog(@"[2]:");
    event.title = @"Event";
    
    //Event has only 5 signs but should has at least 6. Tweak it!
    NSLog(@"[3]:");
    event.title = @"Call with Mike";
    
    //When..Title passed validation. Now creatorLastName is required. Let's say my name is "Foo":
    NSLog(@"[4]:");
    event.creatorLastName = @"Foo";
    
    //What? 4 signs at least? I was born in '88. So I'm Foo88 then:
    NSLog(@"[5]:");
    event.creatorLastName = @"Foo88";
    
    //Well...only letters. At least logical. Maybe I will just type my real lastname:
    NSLog(@"[6]:");
    event.creatorLastName = @"Kaczmarek";
    
    //Oh no! Email is also required? Silly me:
    NSLog(@"[7]:");
    event.email = @"patryk.krzysztof.kaczmarekgmail.com";
    
    //Oh c'mon, just a typo!
    NSLog(@"[8]:");
    event.email = @"patryk.krzysztof.kaczmarek@gmail.com";
    
    //I would start my event in an hour
    NSLog(@"[9]:");
    event.startDate = [NSDate dateWithTimeIntervalSinceNow:3600];
    
    //Take a look on console: "[WARNING] A date which is startDate compared to, is nil". Seems I have to declare endDate too:
    NSLog(@"[10]:");
    event.endDate = [NSDate dateWithTimeIntervalSinceNow:720];
    
    //Don't scream! Just one little 'zero' is missing:
    NSLog(@"[11]:");
    event.endDate = [NSDate dateWithTimeIntervalSinceNow:7200];
    
    //Okie dokie, I will accept that terms...(even don't know what is inside)
    NSLog(@"[12]:");
    event.termsOfUse = YES;
    
    //Finally! success! But hold on...I want to add url to my event:
    NSLog(@"[13]:");
    event.url = @"http://wwwexamplecom";
    
    //Stupid 'dot' key. Seems not working...Copy-paste method should be enough!
    NSLog(@"[14]:");
    event.url = @"http://www.example.com";
}

@end
