//
//  NGRPropertyValidator+NSArray.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21/07/15.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSArray)

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^include)(NSObject *object);

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^exclude)(NSObject *object);

@end
