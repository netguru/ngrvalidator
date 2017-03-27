//
//  NGRPropertyValidator+NGRImage.h
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 23.03.2017.
//
//

#import "NGRPropertyValidator.h"
#import "NGRImage.h"

@interface NGRPropertyValidator (NGRImage)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Rules

/**
 *  Validates if Image property has ratio (in pixels) larger than given ratio.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^minRatio)(CGFloat min);

/**
 *  Validates if Image property has ratio (in pixels) smaller than given ratio.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^maxRatio)(CGFloat max);

/**
 *  Validates if Image property has size (in pixels) smaller than specified (both dimensions).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^maxSize)(CGSize max);

/**
 *  Validates if Image property has size (in pixels) larger than specified (both dimensions).
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^minSize)(CGSize min);

/**
 *  Validates if Image property has height (in pixels) smaller than specified.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^maxHeight)(CGFloat max);

/**
 *  Validates if Image property has height (in pixels) larger than specified.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^minHeight)(CGFloat min);

/**
 *  Validates if Image property has width (in pixels) larger than specified.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^minWidth)(CGFloat min);

/**
 *  Validates if Image property has width (in pixels) smaller than specified.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^maxWidth)(CGFloat max);

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property has wrong ratio.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongRatio)(NSString *message);

/**
 *  User-defined error message used when validated property is too big.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgImageTooBig)(NSString *message);

/**
 *  User-defined error message used when validated property is too small.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgImageTooSmall)(NSString *message);

NS_ASSUME_NONNULL_END


@end
