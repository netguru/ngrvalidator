//
//  NGRUser.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.01.2015.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NGRUserScenario) {
    NGRUserScenarioSignIn,
    NGRUserScenarioPasswordChange
};

@interface NGRUser : NSObject

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *repeatedPassword;

- (NSError *)validateWithScenario:(NGRUserScenario)scenario;

@end
