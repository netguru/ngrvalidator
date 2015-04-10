//
//  NGRValidatorShorthand.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

/**
 *  Defines validated property and initialize validation.
 *
 *  @param  property Name of property given as NSString.
 *  @return instance of NGPropertyValidator used to specify next validation rules.
 *
 *  @discussion In the event of a name clash, don't \#define @c VALIDATOR_SHORTHAND and use the synonym
 *              @c NGRValidate instead.
 */

#define NGRValidate(property) [[NGRPropertyValidator alloc] initWithProperty:property]

#ifdef VALIDATOR_SHORTHAND
    #define validate(property) NGRValidate(property)
#endif
