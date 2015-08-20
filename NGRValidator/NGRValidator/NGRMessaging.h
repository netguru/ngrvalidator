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

/**
 *  Asks delegate for error - messages dictionary for appropriate property key.
 *
 *  @discussion If any error will be encountered by validator, validator will ask delegate first for error description.
 *              If delegate will be nil or validator will not find message for expected error key and property name,
 *              it will use user defined error messages (given in rules block) or default one prepared by library.
 *
 *  Syntax example:
 *                         taken from NGRConstants.h
 *                         v
 *  {@"propertyName" : @{NGRMsgKey : @"Description of an error for given NGRMsgKey"}}
 *       ^
 *       property name
 *
 */
- (NSDictionary *)validationErrorMessagesByPropertyKey;

@end
