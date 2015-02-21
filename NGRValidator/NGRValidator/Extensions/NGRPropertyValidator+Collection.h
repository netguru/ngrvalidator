//
//  NGRPropertyValidator+Collection.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21.02.2015.
//
//

#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (Collection)

@property (copy, nonatomic, readonly) NGRPropertyValidator *(^includes)(id);

@end
