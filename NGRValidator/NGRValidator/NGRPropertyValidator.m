//
//  NGRPropertyValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"
#import "NSObject+NGRValidator.h"
#import "NSArray+NGRValidator.h"
#import "NSString+NGRValidator.h"

NSString * const NGRValidatorDomain = @"com.ngr.validator.domain";
NSInteger const NGRValidationInconsistencyCode = 10000;
NSUInteger const NGRPropertyValidatorDefaultPriority = 100;

@interface NGRPropertyValidator ()

@property (strong, nonatomic, readwrite) NSMutableArray *validators;
@property (strong, nonatomic, readwrite) NSMutableDictionary *messages;
@property (strong, nonatomic, readwrite) NSMutableArray *scenarios;
@property (strong, nonatomic) NSString *localizedPropertyName;
@property (assign, nonatomic) BOOL isRequired;
@property (assign, nonatomic) BOOL allowEmptyProperty;

@end

@implementation NGRPropertyValidator

#pragma mark - Initializers

- (instancetype)initWithProperty:(NSString *)property {
    self = [super init];
    if (self) {
        _property = property;
        _priority = NGRPropertyValidatorDefaultPriority;
        self.isRequired = NO;
        self.allowEmptyProperty = NO;
        [self setupMessages];
    }
    return self;
}

+ (NGRPropertyValidator *)validatorForProperty:(NSString *)property {
    return [[[self class] alloc] initWithProperty:property];
}

#pragma mark - Public Methods

- (NSError *)simpleValidationOfValue:(id)value {
    return [self validationOfValue:value returnTypeClass:[NSError class]];
}

- (NSArray *)complexValidationOfValue:(id)value {
    return [self validationOfValue:value returnTypeClass:[NSArray class]];
}

- (void)validateClass:(Class)aClass withName:(NSString *)name validationBlock:(NGRValidationBlock)block {
    __weak typeof(self) weakSelf = self;

    [self addValidatonBlockWithName:name block:^NGRError (id value) {
        
        BOOL isValueAllowedToBeEmptyOnRequiredRule = weakSelf.allowEmptyProperty && [value ngr_isCountable] && [value ngr_isEmpty] && [name isEqualToString:@"required"];
        BOOL doesValueExistAndIsNotRequired = !weakSelf.isRequired && !value;
        
        if (value && aClass && ![value isKindOfClass:aClass]) {
            return NGRErrorUnexpectedClass;
        } else if (doesValueExistAndIsNotRequired || isValueAllowedToBeEmptyOnRequiredRule) {
            return NGRErrorNoone;
        }
        return block(value);
    }];
}

- (NGRPropertyValidator *(^)(NSArray *))onScenarios {
    return ^(NSArray *scenarios){
        self.scenarios = [scenarios mutableCopy];
        return self;
    };
}

- (NGRPropertyValidator *(^)(NSUInteger))order {
    return ^(NSUInteger priority){
        _priority = priority;
        return self;
    };
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
        [self validateClass:nil withName:@"required" validationBlock:^NGRError(id value) {
            
            BOOL doesValueExist = value && ![value isKindOfClass:[NSNull class]];
            BOOL isValueAllowedToBeEmpty = !self.allowEmptyProperty && [value ngr_isCountable] && [value ngr_isEmpty];
            
            if (!doesValueExist || isValueAllowedToBeEmpty) {
                return NGRErrorRequired;
            }
            return NGRErrorNoone;
        }];
        return self;
    };
}

- (NGRPropertyValidator *(^)())allowEmpty {
    return ^() {
        self.allowEmptyProperty = YES;
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

- (id)validationOfValue:(id)value returnTypeClass:(Class)class {
    
    if (![self shouldValidate]) {
        return nil;
    }
    
    BOOL isSimpleValidation = (class == [NSError class]);
    NSAssert((class == [NSArray class] || class == [NSError class]), @"Allowed class: NSArray or NSError");
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NGRValidationRule *validationRule in self.validators) {
        
        NGRError error = validationRule.validationBlock(value);
        
        if (error == NGRErrorUnexpectedClass) {
            NSAssert(NO, @"Value \"%@\" for \"%@\" parameter is wrong kind of class", value, self.property);
            
        } else if (error != NGRErrorNoone) {
            if (isSimpleValidation) {
                return [self errorWithNGRError:error];
            } else {
                [array addObject:[self errorWithNGRError:error]];
            }
        }
    }
    return isSimpleValidation ? nil : [array copy];
}

- (NSString *)description {
    NSString *scenarios = [self.scenarios componentsJoinedByString:@","];
    return [NSString stringWithFormat:@"<%@: %p, property name: %@, scenario: %@, scenarios(%lu): %@, rules(%lu): %@>", NSStringFromClass([self class]), self, self.property, self.scenario, (unsigned long)[self.scenarios count], scenarios, (unsigned long)[self.validators count], [self validatorsDescription]];
}

- (void)addValidatonBlockWithName:(NSString *)name block:(NGRError (^)(id))block {
    
    if (!self.validators) _validators = [NSMutableArray array];
    
    NGRValidationRule *validatorBlock = [[NGRValidationRule alloc] initWithName:name block:block];
    [self.validators addObject:validatorBlock];
}

- (NSError *)errorWithNGRError:(NGRError)error {
    NSString *propertyName = (self.localizedPropertyName) ?: [self.property ngr_stringByCapitalizeFirstLetter];
    NSString *description = [NSString stringWithFormat:@"%@ %@", propertyName, [self messageForError:error]];
    return [NSError errorWithDomain:NGRValidatorDomain code:NGRValidationInconsistencyCode userInfo:@{NSLocalizedDescriptionKey : description}];
}

- (BOOL)shouldValidate {
    if (!self.scenarios || !self.scenario) {
        return YES;
    }
    //only reached when self.scenario && self.scenarios :
    return [self.scenarios ngr_containsString:self.scenario];
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

- (NSString *)validatorsDescription {
    NSMutableString *validators = [NSMutableString string];
    
    for (NGRValidationRule *rule in self.validators) {
        NSInteger index = [self.validators indexOfObject:rule];
        if (index == [self.validators count] - 1) {
            [validators appendFormat:@"%@", rule.name];
        } else {
            [validators appendFormat:@"%@, ", rule.name];
        }
    }
    return [validators copy];
}

@end
