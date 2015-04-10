//
//  NGRValidatorDeprecated.h
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 10/04/15.
//
//

#define NGR_DEPRECATED __attribute__((deprecated("This method has been deprecated and will be removed.")))
#define NGR_DEPRECATED_USE_INSTEAD(METHOD) __attribute__((deprecated("This method has been deprecated and will be removed. Please use `" METHOD "` instead.")))
