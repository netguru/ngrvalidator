//
//  NGRPropertyValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

NSString * const NGRValidatorDomain = @"com.ngr.validator.domain";
NSInteger const NGRValidationInconsistencyCode = 10000;

@interface NGRPropertyValidator ()

@property (strong, nonatomic, readwrite) NSMutableArray *validators;
@property (strong, nonatomic, readwrite) NSMutableDictionary *messages;
@property (strong, nonatomic) NSString *localizedPropertyName;
@property (assign, nonatomic) BOOL isRequired;

@end

@implementation NGRPropertyValidator

#pragma mark - Initializers

- (instancetype)initWithProperty:(NSString *)property {
    self = [super init];
    if (self) {
        _property = property;
        self.isRequired = NO;
        [self setupMessages];
    }
    return self;
}

+ (NGRPropertyValidator *)validatorForProperty:(NSString *)property {
    return [[[self class] alloc] initWithProperty:property];
}

#pragma mark - Public Methods

- (NSError *)simpleValidationOfValue:(id)value {
    
    for (NGRValidationBlock block in self.validators) {
        NGRError error = block(value);
        
        if (error == NGRErrorUnexpectedClass) {
             NSAssert(NO, @"Parameter %@ is wrong kind of class", value);
        } else if (error != NGRErrorNoone) {
            return [self errorWithNGRError:error];
        }
    }
    return nil;
}

- (NSArray *)complexValidationOfValue:(id)value {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NGRValidationBlock block in self.validators) {
        NGRError error = block(value);
        if (error == NGRErrorUnexpectedClass) {
            NSAssert(NO, @"Parameter %@ is wrong kind of class", value);
        } else if (error != NGRErrorNoone) {
            [array addObject:[self errorWithNGRError:error]];
        }
    }
    return array;
}

- (void)validateClass:(Class)aClass withBlock:(NGRValidationBlock)validationBlock {
    __weak typeof(self) weakSelf = self;
    
    [self addValidatonWithBlock:^NGRError (id value) {
        
        if (value && aClass && ![value isKindOfClass:aClass]) {
            return NGRErrorUnexpectedClass;
        } else if (!weakSelf.isRequired && !value) {
            return NGRErrorNoone;
        }
        return validationBlock(value);
    }];
}

- (NGRPropertyValidator *(^)(NSString *))localizedName {
    return ^(NSString *message) {
        self.localizedPropertyName = message;
        return self;
    };
}

- (NGRPropertyValidator *(^)())required {
    return ^() {
        self.isRequired = YES;
        [self validateClass:nil withBlock:^NGRError(id value) {
            return (!value || [value isKindOfClass:[NSNull class]]) ? NGRErrorRequired : NGRErrorNoone;
        }];
        return self;
    };
}

- (void)setMessage:(NSString *)message forError:(NGRError)error {
    self.messages[@(error)] = message;
}

- (NSString *)messageForError:(NGRError)error {
    return self.messages[@(error)];
}

#pragma mark - Private Methods

- (void)addValidatonWithBlock:(NGRError (^)(id))validationBlock {
    
    if (!self.validators) self.validators = [NSMutableArray array];
    [self.validators addObject:validationBlock];
}

- (NSError *)errorWithNGRError:(NGRError)error {
    NSString *propertyName = (self.localizedPropertyName) ?: [self.property capitalizedString];
    NSString *description = [NSString stringWithFormat:@"%@ %@", propertyName, [self messageForError:error]];
    return [NSError errorWithDomain:NGRValidatorDomain code:NGRValidationInconsistencyCode userInfo:@{NSLocalizedDescriptionKey : description}];
}

- (void)setupMessages {
    
    if (!self.messages) _messages = [NSMutableDictionary dictionary];
    
    //NGPropertyValidator + NSObject
    [self setMessage:@"is required." forError:NGRErrorRequired];
    [self setMessage:@"custom condition was not fulfilled." forError:NGRErrorCustomCondition];
    
    //NGPropertyValidator + NSString
    [self setMessage:@"is too long." forError:NGRErrorTooLong];
    [self setMessage:@"is too short." forError:NGRErrorTooShort];
    [self setMessage:@"should be decimal." forError:NGRErrorNotDecimal];
    [self setMessage:@"is of the wrong length." forError:NGRErrorNotExactLength];
    [self setMessage:@"is not repeated exactly." forError:NGRErrorNotMatch];
    
    //NGPropertyValidator + NSNumber
    [self setMessage:@"is too small." forError:NGRErrorTooSmall];
    [self setMessage:@"is too big." forError:NGRErrorTooBig];
    [self setMessage:@"isn't exact." forError:NGRErrorNotExact];
    [self setMessage:@"isn't false." forError:NGRErrorNotFalse];
    [self setMessage:@"isn't true." forError:NGRErrorNotTrue];
    
    //NGPropertyValidator + Syntax
    [self setMessage:@"has invalid syntax." forError:NGRErrorNotEmail];
    [self setMessage:@"should contains only letters." forError:NGRErrorNotName];
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
