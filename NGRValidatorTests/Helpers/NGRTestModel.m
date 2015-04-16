//
//  NGRTestModel.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 06/04/15.
//
//

#import "NGRTestModel.h"

@implementation NGRTestModel

- (NSDictionary *)validationErrorMessagesByPropertyKey {
    return @{@"value" : @{MSGTooShort : @"Fixture too short message"}};
}

@end
