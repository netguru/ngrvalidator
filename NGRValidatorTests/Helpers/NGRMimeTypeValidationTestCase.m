//
//  NGRMimeTypeValidationTestCase.m
//  NGRValidator
//
//
//

#import "NGRMimeTypeValidationTestCase.h"

@implementation NGRMimeTypeValidationTestCase

- (instancetype)initWithMimeType:(NGRMimeType *)type withCases:(NSArray<NGRTestData *> *)cases {
    self = [super init];
    if (self) {
        _mimeType = type;
        _cases = cases;
    }
    return self;
}

+ (instancetype)test:(NGRMimeType *)type withCases:(NSArray<NGRTestData *> *)cases {
    return [[self alloc] initWithMimeType:type withCases:cases];
}

- (NSString *)name {
    NSString *typeName = [[self.mimeType componentsSeparatedByString:@"/"] lastObject];
    return [NSString stringWithFormat:@"Validation of %@", typeName];
}

- (NSArray <NGRTestData *> *)validCases {
    NSMutableArray<NGRTestData *> *valid = [NSMutableArray new];
    
    for (NGRTestData *testData in self.cases) {
        if ([testData.mimeTypes containsObject:self.mimeType]) {
            [valid addObject:testData];
        }
    }
    
    return [valid copy];
}

- (NSArray <NGRTestData *> *)invalidCases {
    NSMutableArray<NGRTestData *> *invalid = [NSMutableArray new];
    
    for (NGRTestData *testData in self.cases) {
        if (![testData.mimeTypes containsObject:self.mimeType]) {
            [invalid addObject:testData];
        }
    }
    
    return [invalid copy];
}

@end
