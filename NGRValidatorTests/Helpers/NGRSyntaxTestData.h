//
//  NGRSyntaxTestData.h
//  NGRValidator
//

#import <Foundation/Foundation.h>

@interface NGRSyntaxTestData : NSObject

@property (nonatomic, strong, readonly) NSString *syntaxName;
@property (nonatomic, assign, readonly) NGRSyntax syntax;
@property (nonatomic, strong, readonly) NSString *valid;
@property (nonatomic, strong, readonly) NSString *invalid;
    
+ (instancetype)test:(NSString *)syntaxName syntax:(NGRSyntax)syntaxId valid:(NSString *)valid invalid:(NSString *)invalid;

- (NSString *)name;
    
@end
