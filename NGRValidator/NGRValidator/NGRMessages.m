//
//  NGRMessages.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21.02.2015.
//
//

#import "NGRMessages.h"
#import "NGRConstants.h"

@interface NGRMessages ()

@property (strong, nonatomic) NSMutableDictionary *messages;

@end

@implementation NGRMessages

- (instancetype)init {
    self = [super init];
    if (self) {
        _messages = [NSMutableDictionary dictionary];
        [self setupMessages];
    }
    return self;
}

#pragma mark - Public

- (void)setMessage:(NSString *)message forKey:(NGRMsgKey *)key {
    self.messages[key] = message;
}

- (NSString *)messageForKey:(NGRMsgKey *)key {
    return self.messages[key];
}

#pragma mark - Private

- (void)setupMessages {
    
    //NGPropertyValidator + NSObject
    [self setMessage:@"is required." forKey:MSGNil];

    //NGPropertyValidator + NSString
    [self setMessage:@"is too long." forKey:MSGTooLong];
    [self setMessage:@"is too short." forKey:MSGTooShort];
    [self setMessage:@"should be decimal." forKey:MSGNotDecimal];
    [self setMessage:@"is of the wrong length." forKey:MSGNotExactLength];
    [self setMessage:@"is not repeated exactly." forKey:MSGNotMatch];
    [self setMessage:@"does not differ." forKey:MSGNotDiffer];
    
    //NGPropertyValidator + NSNumber
    [self setMessage:@"is too small." forKey:MSGTooSmall];
    [self setMessage:@"is too big." forKey:MSGTooBig];
    [self setMessage:@"isn't exact." forKey:MSGNotExact];
    [self setMessage:@"isn't false." forKey:MSGNotFalse];
    [self setMessage:@"isn't true." forKey:MSGNotTrue];
    
    //NGPropertyValidator + Syntax
    [self setMessage:@"has invalid syntax." forKey:MSGNotEmail];
    [self setMessage:@"should contain only letters." forKey:MSGNotName];
    [self setMessage:@"has invalid syntax." forKey:MSGNotHTTP];
    [self setMessage:@"do not match pattern." forKey:MSGWrongRegex];
    
    //NGPropertyValidator + Compare
    [self setMessage:@"isn't earlier than compared date." forKey:MSGNotEarlierThan];
    [self setMessage:@"isn't later than compared date." forKey:MSGNotLaterThan];
    [self setMessage:@"isn't earlier than or equal to compared date." forKey:MSGNotEarlierThanOrEqualTo];
    [self setMessage:@"isn't later than or equal to compared date." forKey:MSGNotLaterThanOrEqualTo];
    [self setMessage:@"isn't between given dates." forKey:MSGNotBetweenDates];
    
    //NGPropertyValidator + NSArray
    [self setMessage:@"doesn't exclude given value." forKey:MSGNotExcludes];
    [self setMessage:@"doesn't include given value." forKey:MSGNotIncludes];
    [self setMessage:@"isn't included in array." forKey:MSGNotIncludedIn];
    [self setMessage:@"isn't excluded from array." forKey:MSGNotExcludedFrom];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, number of messages: %lu>", NSStringFromClass([self class]), self, (unsigned long)self.messages.count];
}

@end
