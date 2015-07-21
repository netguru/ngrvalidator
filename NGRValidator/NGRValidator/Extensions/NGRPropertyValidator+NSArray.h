//
//  NGRPropertyValidator+NSArray.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21/07/15.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSArray)

#pragma mark - Rules

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^include)(NSObject *object);

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^exclude)(NSObject *object);

#pragma mark - Messaging

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotInclude)(NSString *message);

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgNotExclude)(NSString *message);

@end
