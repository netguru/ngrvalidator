//
//  NGRMessages.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 21.02.2015.
//
//

#import "NGRMessages.h"

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

- (void)setMessage:(NSString *)message forError:(NGRError)error {
    self.messages[@(error)] = message;
}

- (NSString *)messageForError:(NGRError)error {
    return self.messages[@(error)];
}

- (void)setupMessages {
    
    //NGPropertyValidator + NSObject
    [self setMessage:@"is required." forError:NGRErrorRequired];
    [self setMessage:@"custom condition was not fulfilled." forError:NGRErrorCustomCondition];
    
    //NGPropertyValidator + NSString
    [self setMessage:@"is too long." forError:NGRErrorTooLong];
    [self setMessage:@"is too short." forError:NGRErrorTooShort];
    [self setMessage:@"should be decimal." forError:NGRErrorNotDecimal];
    [self setMessage:@"is of the wrong length." forError:NGRErrorNotExactLength];
    [self setMessage:@"is not repeated exactly." forError:NGRErrorNotMatch];
    [self setMessage:@"does not differ." forError:NGRErrorNotDiffer];
    
    //NGPropertyValidator + NSNumber
    [self setMessage:@"is too small." forError:NGRErrorTooSmall];
    [self setMessage:@"is too big." forError:NGRErrorTooBig];
    [self setMessage:@"isn't exact." forError:NGRErrorNotExact];
    [self setMessage:@"isn't false." forError:NGRErrorNotFalse];
    [self setMessage:@"isn't true." forError:NGRErrorNotTrue];
    
    //NGPropertyValidator + Syntax
    [self setMessage:@"has invalid syntax." forError:NGRErrorNotEmail];
    [self setMessage:@"should contain only letters." forError:NGRErrorNotName];
    [self setMessage:@"has invalid syntax." forError:NGRErrorNotURL];
    [self setMessage:@"do not match pattern." forError:NGRErrorWrongRegex];
    
    //NGPropertyValidator + Compare
    [self setMessage:@"isn't earlier than compared date." forError:NGRErrorNotEarlierThan];
    [self setMessage:@"isn't later than compared date." forError:NGRErrorNotLaterThan];
    [self setMessage:@"isn't earlier than or equal to compared date." forError:NGRErrorNotEarlierThanOrEqualTo];
    [self setMessage:@"isn't later than or equal to compared date." forError:NGRErrorNotLaterThanOrEqualTo];
    [self setMessage:@"isn't between given dates." forError:NGRErrorNotBetweenDates];
}

@end
