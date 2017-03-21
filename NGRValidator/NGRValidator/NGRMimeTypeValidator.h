//
//  NGRMimeTypeValidator.h
//  NGRValidator
//
//
//

#import "NGRMimeType.h"

@interface NGRMimeTypeValidator : NSObject

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^NGRMimeTypeValidationBlock)(NSData *);

@property (nonatomic, copy, readonly) NGRMimeTypeValidationBlock isValid;

+ (instancetype)validatorWithValidationBlock:(NGRMimeTypeValidationBlock)block;

//https://www.filesignatures.net/
+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size withOffset:(unsigned long)offset;

+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size;

+ (instancetype)validatorWithAnyOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators;

+ (instancetype)validatorWithAllOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators;

+ (NGRMimeTypeValidator *)validatorForMimeType:(NGRMimeType *)type;

NS_ASSUME_NONNULL_END

@end
