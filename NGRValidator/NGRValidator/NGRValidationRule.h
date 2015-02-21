//
//  NGRBlockDescriptor.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRTypedefs.h"

@interface NGRValidationRule : NSObject

- (instancetype)initWithName:(NSString *)name block:(NGRValidationBlock)block NS_DESIGNATED_INITIALIZER;

@property (strong, readonly, nonatomic) NSString *name;

@property (copy, readonly, nonatomic) NGRValidationBlock validationBlock;

@end
