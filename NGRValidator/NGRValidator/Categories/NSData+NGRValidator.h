//
//  NSData+NGRValidator.h
//  NGRValidator
//
//
//

#import "NGRMimeType.h"

@interface NSData (NGRValidator)

NS_ASSUME_NONNULL_BEGIN

- (BOOL)ngr_hasMimeType:(NGRMimeType *)type;

- (BOOL)ngr_isImage;
- (BOOL)ngr_isVideo;
- (BOOL)ngr_isAudio;
- (BOOL)ngr_isArchive;

NS_ASSUME_NONNULL_END

@end
