//
//  NGRMimeTypeMetadata.h
//  NGRValidator
//
//
//

#import "NGRMimeType.h"

@interface NGRMimeTypeMetadata : NSObject

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, assign, readonly) const char *signature;
@property (nonatomic, assign, readonly) unsigned long length;

+ (instancetype)dataWithSignature:(const char *)signature;

NS_ASSUME_NONNULL_END

@end
