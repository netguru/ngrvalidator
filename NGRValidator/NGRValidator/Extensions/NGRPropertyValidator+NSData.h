//
//  NGRPropertyValidator+NSData.h
//  NGRValidator
//
//
//

#import "NGRMimeType.h"
#import "NGRPropertyValidator.h"

@interface NGRPropertyValidator (NSData)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Rules

/**
 *  Validates if NSData property has byte size smaller (or equal) than specified.
*/
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^maxByteSize)(NSUInteger max);

/**
 *  Validates if NSData property has byte size larger (or equal) than specified.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^minByteSize)(NSUInteger min);
    
/**
 *  Validates if NSData property has given MIME type.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^mimeType)(NGRMimeType *mimeType);

/**
 *  Validates if NSData property contains image.
 *
 *  @remark This method detects only image types defined in NGRMimeType.h
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^image)();

/**
 *  Validates if NSData property contains video.
 *
 *  @remark This method detects only video types defined in NGRMimeType.h
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^video)();

/**
 *  Validates if NSData property contains audio.
 *
 *  @remark This method detects only audio types defined in NGRMimeType.h
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^audio)();

/**
 *  Validates if NSData property is an archive.
 *
 *  @remark This method detects only archive types defined in NGRMimeType.h
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^archive)();

#pragma mark - Messaging

/**
 *  User-defined error message used when validated property has wrong MIME type.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongMIMEType)(NSString *message);

/**
 *  User-defined error message used when validated property has wrong media type.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgWrongMediaType)(NSString *message);
    
/**
 *  User-defined error message used when validated property has too small byte size.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgByteSizeTooSmall)(NSString *message);
    
/**
 *  User-defined error message used when validated property has too big byte size.
 */
@property (copy, nonatomic, readonly) NGRPropertyValidator *(^msgByteSizeTooBig)(NSString *message);

NS_ASSUME_NONNULL_END

@end
