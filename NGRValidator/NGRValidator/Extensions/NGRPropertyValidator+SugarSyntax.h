//
//  NGRPropertyValidator+SugarSyntax.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 07/04/15.
//
//

#import "NGRPropertyValidator.h"

/**
 *  All properties in this class are syntactic sugar and can be safely omitted.
 *  They improve readability and introduce natural speech to code.
 *
 *  Note difference between sugar syntax and regular validation method:
 *
 *                               validation method has to be invoke always with parentheses (even if do not take any parameter).
 *                               v
 *  validate(@"password").is.required()
 *                         ^
 *                         sugar syntax is always invoked without parentheses.
 */
@interface NGRPropertyValidator (SugarSyntax)

@property (nonatomic, strong, readonly) NGRPropertyValidator *is;

@property (nonatomic, strong, readonly) NGRPropertyValidator *are;

@property (nonatomic, strong, readonly) NGRPropertyValidator *on;

@property (nonatomic, strong, readonly) NGRPropertyValidator *has;

@property (nonatomic, strong, readonly) NGRPropertyValidator *have;

@property (nonatomic, strong, readonly) NGRPropertyValidator *to;

@property (nonatomic, strong, readonly) NGRPropertyValidator *toNot;

@property (nonatomic, strong, readonly) NGRPropertyValidator *notTo;

@property (nonatomic, strong, readonly) NGRPropertyValidator *be;

@property (nonatomic, strong, readonly) NGRPropertyValidator *with;

@property (nonatomic, strong, readonly) NGRPropertyValidator *should;

@end
