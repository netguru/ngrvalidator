//
//  NGRSyntaxTestData.m
//  NGRValidator
//
//  Created by Krzysztof Kapitan on 27.03.2017.
//
//

#import "NGRSyntaxTestData.h"

@implementation NGRSyntaxTestData

- (instancetype)initWithName:(NSString *)syntaxName syntax:(NGRSyntax)syntax valid:(NSString *)valid invalid:(NSString *)invalid {
    self = [super init];
    if (self) {
        _syntaxName = syntaxName;
        _syntax = syntax;
        _valid = valid;
        _invalid = invalid;
    }
    return self;
}

+ (instancetype)test:(NSString *)syntaxName syntax:(NGRSyntax)syntax valid:(NSString *)valid invalid:(NSString *)invalid {
    return [[self alloc] initWithName:syntaxName syntax:syntax valid:valid invalid:invalid];
}
    
- (NSString *)name {
    return [NSString stringWithFormat:@"syntax %@ validator", self.syntaxName];
}
    
@end
