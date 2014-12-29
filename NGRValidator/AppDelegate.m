//
//  AppDelegate.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "AppDelegate.h"
#import "CalendarEvent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CalendarEvent *event = [[CalendarEvent alloc] init];
    
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
    
    return YES;
}


@end
