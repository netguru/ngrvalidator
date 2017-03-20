//
//  NGRMimeTypeMetadata.h
//  NGRValidator
//
//
//

#import "NGRMimeType.h"

@interface NGRMimeTypeMetadata : NSObject

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, strong, readonly) NGRMimeType *name;

@property (nonatomic, assign, readonly) const char *signature;
@property (nonatomic, assign, readonly) unsigned long length;

- (instancetype)initWithName:(NGRMimeType *)name signature:(const char *)signature length:(unsigned long)length;

NS_ASSUME_NONNULL_END

@end
