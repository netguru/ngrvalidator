//
//  NGRMessaging.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 09/04/15.
//
//

#import <Foundation/Foundation.h>

@protocol NGRMessaging <NSObject>

@required

- (NSDictionary *)validationErrorMessagesByPropertyKey;

@end
