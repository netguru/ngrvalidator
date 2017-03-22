//
//  NGRMimeTypeValidatorTestCase.h
//  NGRValidator
//
//
//

#import <Foundation/Foundation.h>

@interface NGRMimeTypeValidationTestCase : NSObject

@property(nonatomic, strong, readonly) NGRMimeType *mimeType;
@property(nonatomic, strong, readonly) LazyNSData validData;
@property(nonatomic, strong, readonly) LazyNSData invalidData;

+ (instancetype)test:(NGRMimeType *)type valid:(LazyNSData)valid invalid:(LazyNSData)invalid;

- (NSString *)name;

@end
