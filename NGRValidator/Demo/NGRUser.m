//
//  NGRUser.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import "NGRUser.h"
#import "NGRValidator.h"

NSString * const NGRUserChangePassScenario = @"changePass";
NSString * const NGRUserSignInScenario = @"signIn";

@implementation NGRUser

- (NSError *)validateWithScenario:(NGRUserScenario)scenario {
    
    NSError *error = nil;
    [NGRValidator validateModel:self error:&error scenario:[self stringFromScenario:scenario] usingRules:^NSArray *{
        return @[validate(@"password").required().minLength(5).msgTooShort(@"should have at least 5 signs"),
                 validate(@"repeatedPassword").required().match(self.password).onScenarios(@[NGRUserChangePassScenario]).localizedName(@"New password")];
    }];
    return error;
}

- (NSString *)stringFromScenario:(NGRUserScenario)scenario {
    switch (scenario) {
        default:
        case NGRUserScenarioSignIn:
            return NGRUserSignInScenario;
            
        case NGRUserScenarioPasswordChange:
            return NGRUserChangePassScenario;
    }
}

@end
