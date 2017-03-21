//
//  NGRMimeTypeValidatorTestCase.h
//  NGRValidator
//
//
//

#import <Foundation/Foundation.h>

@interface NGRMimeTypeValidationTestCase : NSObject

@property(nonatomic, strong, readonly) NGRMimeType *mimeType;
@property(nonatomic, strong, readonly) NSData *validData;
@property(nonatomic, strong, readonly) NSData *invalidData;

+ (instancetype)test:(NGRMimeType *)type valid:(NSData *)valid invalid:(NSData *)invalid;

- (NSString *)name;

@end
