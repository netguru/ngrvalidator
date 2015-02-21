//
//  NGRTypedefs.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21.02.2015.
//
//

#ifndef NGRValidator_NGRTypedefs_h
#define NGRValidator_NGRTypedefs_h

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
    NGRErrorNotURL,
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
