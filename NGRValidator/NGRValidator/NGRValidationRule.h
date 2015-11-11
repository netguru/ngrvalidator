//
//  NGRBlockDescriptor.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 31.12.2014.
//
//

#import <Foundation/Foundation.h>
#import "NGRConstants.h"

@interface NGRValidationRule : NSObject

/**
 *  Designated initializer of NGRValidationRule.
 *
 *  @param name  Validation rule name stored for easier access and identification.
 *  @param block Actual block with validation expression.
 *
 *  @return Instance of receiver.
 */
- (instancetype)initWithName:(NSString *)name block:(NGRValidationBlock)block NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Validation rule name stored for easier access and identification.
 */
@property (strong, readonly, nonatomic) NSString *name;

/**
 *  Block which contains validation expression.
 */
@property (copy, readonly, nonatomic) NGRValidationBlock validationBlock;

@end
