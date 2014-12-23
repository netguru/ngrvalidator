//
//  NGRPropertyValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"

NSString * const NGRValidatorDomain = @"com.ng.validator.domain";
NSInteger const NGRValidationInconsistencyCode = 10000;

@interface NGRPropertyValidator ()

@property (strong, nonatomic, readwrite) NSMutableArray *validators;
@property (strong, nonatomic, readwrite) NSMutableDictionary *messages;
@property (strong, nonatomic) NSString *localizedPropertyName;

@end

@implementation NGRPropertyValidator

#pragma mark - Initializers

- (instancetype)initWithProperty:(NSString *)property {
    self = [super init];
    if (self) {
        _property = property;
        _localizedPropertyName = property;
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
        
        if (error != NGRErrorNoone) {
            return [self errorWithNGRError:error];
        }
    }
    return nil;
}

- (NSArray *)complexValidationOfValue:(id)value {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NGRValidationBlock block in self.validators) {
        NGRError error = block(value);
        if (error != NGRErrorNoone) {
            [array addObject:[self errorWithNGRError:error]];
        }
    }
    return array;
}

- (void)validateClass:(Class)aClass withBlock:(NGRValidationBlock)validationBlock {
    __weak typeof(self) weakSelf = self;
    
    [self addValidatonWithBlock:^NGRError (NSString *value) {
        if (aClass != nil && ![weakSelf isObject:value kindOfClass:aClass]) {
            return NGRErrorUnexpectedClass;
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

- (BOOL)isObject:(NSObject *)object kindOfClass:(Class)aClass {
    
    if (object == nil) {
        NSLog(@"Cannot validate property when is nil. Validation skipped");
        return NO;
        
    } else if (![object isKindOfClass:aClass]) {
        NSAssert(NO, @"Parameter %@ is not kind of %@ class", object, aClass);
    }
    return YES;
}

- (NSError *)errorWithNGRError:(NGRError)error {
    NSString *description = [NSString stringWithFormat:@"%@ %@", (self.localizedPropertyName) ?: self.property, [self messageForError:error]];
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
    [self setMessage:@"has invalid email syntax." forError:NGRErrorNotEmail];
    [self setMessage:@"has invalid name syntax." forError:NGRErrorNotName];
    [self setMessage:@"has invalid url syntax." forError:NGRErrorNotURL];
    [self setMessage:@"do not match pattern." forError:NGRErrorWrongRegex];
}

@end
