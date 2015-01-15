//
//  NGRErrors.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#ifndef NGRValidator_NGRErrors_h
#define NGRValidator_NGRErrors_h

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

#endif
