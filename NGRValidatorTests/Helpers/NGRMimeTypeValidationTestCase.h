//
//  NGRMimeTypeValidatorTestCase.h
//  NGRValidator
//
//
//

#import <Foundation/Foundation.h>

@interface NGRMimeTypeValidationTestCase : NSObject

@property(nonatomic, strong, readonly) NGRMimeType *mimeType;
@property(nonatomic, strong, readonly) NSArray<NGRTestData *> *cases;

+ (instancetype)test:(NGRMimeType *)type withCases:(NSArray<NGRTestData *> *)cases;

- (NSString *)name;
- (NSArray <NGRTestData *> *)validCases;
- (NSArray <NGRTestData *> *)invalidCases;


@end
