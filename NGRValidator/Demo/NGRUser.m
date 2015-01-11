//
//  NGRUser.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRUser.h"
#import "NGRValidator.h"

@implementation NGRUser

- (NSError *)validateWithScenario:(NGRUserScenario)scenario {
    NSString *stringScenario = [self stringFromScenario:scenario];
    //to do
    return nil;
    
}

- (NSString *)stringFromScenario:(NGRUserScenario)scenario {
    switch (scenario) {
        default:
        case NGRUserScenarioSignIn:
            return @"signin";
            
        case NGRUserScenarioPasswordChange:
            return @"changePass";
    }
}

@end
