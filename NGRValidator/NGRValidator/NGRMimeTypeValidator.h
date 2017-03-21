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
+ (instancetype)validatorWithSignature:(const char *)signature ofSize:(size_t)size;
+ (instancetype)validatorWithAnyOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators;
+ (instancetype)validatorWithAllOfValidators:(NSArray<NGRMimeTypeValidator *> *)validators;

+ (NGRMimeTypeValidator *)validatorForMimeType:(NGRMimeType *)type;

NS_ASSUME_NONNULL_END

@end

@interface NGRMimeTypeValidator (Image)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)png;
+ (instancetype)jpg;
+ (instancetype)tiff;
+ (instancetype)ico;
+ (instancetype)bmp;
+ (instancetype)gif;

NS_ASSUME_NONNULL_END

@end

@interface NGRMimeTypeValidator (Video)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)_3gp;
+ (instancetype)avi;
+ (instancetype)mkv;
+ (instancetype)mp4;

NS_ASSUME_NONNULL_END

@end

@interface NGRMimeTypeValidator (Audio)

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)wav;
+ (instancetype)mp3;
+ (instancetype)flac;
+ (instancetype)midi;

NS_ASSUME_NONNULL_END

@end
