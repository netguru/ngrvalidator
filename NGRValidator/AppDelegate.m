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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NGRTestModel *model = [[NGRTestModel alloc] init];
    //    model.name = @"my_custom_name";
    model.email = @"email@example.com";
    model.number = @10;
    model.aFloat = 12.0f;
    model.aBool = NO;
    
    NSError *error = nil;
    [NGRValidator validateModel:model error:&error usingRules:^NSArray *{
        return @[NGRValidate(@"email").required()];
    }];
    
    NSLog(@"%@", error);
    
    return YES;
    
    return YES;
}

@end
