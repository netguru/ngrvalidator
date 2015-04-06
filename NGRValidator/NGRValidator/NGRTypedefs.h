//
//  NGRTypedefs.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21.02.2015.
//
//

#ifndef NGRValidator_NGRTypedefs_h
#define NGRValidator_NGRTypedefs_h

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

typedef NS_ENUM(NSInteger, NGRError) {
    NGRErrorNoone,
    NGRErrorUnexpectedClass,
    
    //NGRPropertyValidator + NSObject
    NGRErrorRequired,
    NGRErrorCustomCondition,
    
    //NGRPropertyValidator + NSString
    NGRErrorTooLong,
    NGRErrorTooShort,
    NGRErrorNotDecimal,
    NGRErrorNotExactLength,
    NGRErrorNotMatch,
    NGRErrorNotDiffer,
    
    //NGRPropertyValidator + NSNumber
    NGRErrorTooSmall,
    NGRErrorTooBig,
    NGRErrorNotExact,
    NGRErrorNotFalse,
    NGRErrorNotTrue,
    
    //NGRPropertyValidator + Syntax
    NGRErrorNotEmail,
    NGRErrorNotName,
    NGRErrorNotHTTP,
    NGRErrorWrongRegex,
    
    //NGRPropertyValidator + NSDate
    NGRErrorNotEarlierThan,
    NGRErrorNotLaterThan,
    NGRErrorNotEarlierThanOrEqualTo,
    NGRErrorNotLaterThanOrEqualTo,
    NGRErrorNotBetweenDates,
};

typedef NGRError (^NGRValidationBlock)(id);

#endif
