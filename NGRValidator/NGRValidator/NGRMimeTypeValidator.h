//
//  NGRMimeTypeValidator.h
//  NGRValidator
//

#import "NGRMimeType.h"

/** 
 *  This class represents the validator capable of checking whether given NSData has specific MIMEType.
 *  Most of the time this involves checking specific bytes of the data called the file signature or magic number.
 *  Each type has its own signature (possibly more than one) - check them here https://www.filesignatures.net/
 */

@interface NGRMimeTypeValidator : NSObject

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^NGRMimeTypeValidationBlock)(NSData *);

/**
 *  Validation block responsible for checking the MIMEType.
 */
@property (nonatomic, copy, readonly) NGRMimeTypeValidationBlock isValid;

/**
 *  Initializes validator with given validation block.
 *
 *  @param  Validation block of type NGRMimeTypeValidationBlock with NSData as parameter and BOOL as return type.
 *  @return Instance of NGRMimeTypeValidator used to validate NSData against specific MIMEType.
 */
+ (instancetype)validatorWithValidationBlock:(NGRMimeTypeValidationBlock)block;

/**
 *  Initializes validator validating the MIMEType based on its signature.
 *
 *  @param Signature - const char * containing bytes which represents the signature.
 *  @param Size - size_t containing the size of a signature in bytes.
 *  @param Offset - unsigned long containing the position in the NSData byte representation from where the signature starts.
 *  @return Instance of NGRMimeTypeValidator used to validate NSData against specific MIMEType.
 */
+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size withOffset:(unsigned long)offset;

/**
 *  Initializes validator validating the MIMEType based on its signature.
 *
 *  @param Signature - const char * containing bytes which represents the signature.
 *  @param Size - size_t containing the size of a signature in bytes.
 *  @return Instance of NGRMimeTypeValidator used to validate NSData against specific MIMEType.
 */
+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size;

/**
 *  Initializes validator validating the MIMEType based on combination of other validators.
 *  It will succeed if ANY of the child validators succeeds.
 *
 *  @param Validators - NSArray<NGRMimeTypeValidator *> * containing the array of validators to combine.
 *  @return Instance of NGRMimeTypeValidator used to validate NSData against specific MIMEType.
 */
+ (instancetype)validatorWithAnyOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators;

/**
 *  Initializes validator validating the MIMEType based on combination of other validators.
 *  It will succeed if ALL of the child validators succeeds.
 *
 *  @param Validators - NSArray<NGRMimeTypeValidator *> * containing the array of validators to combine.
 *  @return Instance of NGRMimeTypeValidator used to validate NSData against specific MIMEType.
 */
+ (instancetype)validatorWithAllOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators;

/**
 *  Returns validator for given MIMEType.
 *
 *  @param Type - NGRMimeType containing the MIMEType to get the validator for.
 *  @return Instance of NGRMimeTypeValidator used to validate NSData against specific MIMEType.
 */
+ (NGRMimeTypeValidator *)validatorForMimeType:(NGRMimeType *)type;

NS_ASSUME_NONNULL_END

@end
