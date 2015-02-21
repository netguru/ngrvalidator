//
//  NGRPropertyValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRPropertyValidator.h"
#import "NGRValidationRule.h"

#import "NSObject+NGRValidator.h"
#import "NSArray+NGRValidator.h"
#import "NSString+NGRValidator.h"


NSString * const NGRValidatorDomain = @"com.ngr.validator.domain";
NSInteger const NGRValidationInconsistencyCode = 10000;
NSUInteger const NGRPropertyValidatorDefaultPriority = 100;

@interface NGRPropertyValidator ()

@property (strong, nonatomic, readwrite) NSMutableArray *validationRules;
@property (strong, nonatomic, readwrite) NGRMessages *messages;
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
        _messages = [[NGRMessages alloc] init];
        _validationRules = [NSMutableArray array];
        _isRequired = NO;
        _allowEmptyProperty = NO;
    }
    return self;
}

#pragma mark - Public Methods

- (NSError *)simpleValidationOfValue:(id)value {
    return [self validateValue:value usingSimpleValidation:YES];
}

- (NSArray *)complexValidationOfValue:(id)value {
    return [self validateValue:value usingSimpleValidation:NO];
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

#pragma mark - Private Methods

- (id)validateValue:(id)value usingSimpleValidation:(BOOL)simpleValidation {
    
    if (![self shouldValidate]) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NGRValidationRule *validationRule in self.validationRules) {
        
        NGRError error = validationRule.validationBlock(value);
        
        if (error == NGRErrorUnexpectedClass) {
            NSAssert(NO, @"Value \"%@\" for \"%@\" parameter is wrong kind of class", value, self.property);
            
        } else if (error != NGRErrorNoone) {
            if (simpleValidation) {
                return [self errorWithNGRError:error];
            } else {
                [array addObject:[self errorWithNGRError:error]];
            }
        }
    }
    return simpleValidation ? nil : [array copy];
}

- (void)addValidatonBlockWithName:(NSString *)name block:(NGRError (^)(id))block {
    
    NGRValidationRule *validatorRule = [[NGRValidationRule alloc] initWithName:name block:block];
    [self.validationRules addObject:validatorRule];
}

- (NSError *)errorWithNGRError:(NGRError)error {
    NSString *propertyName = (self.localizedPropertyName) ?: [self.property ngr_stringByCapitalizeFirstLetter];
    NSString *description = [NSString stringWithFormat:@"%@ %@", propertyName, [self.messages messageForError:error]];
    return [NSError errorWithDomain:NGRValidatorDomain code:NGRValidationInconsistencyCode userInfo:@{NSLocalizedDescriptionKey : description}];
}

- (BOOL)shouldValidate {
    if (!self.scenarios || !self.scenario) {
        return YES;
    }
    //only reached when self.scenario && self.scenarios :
    return [self.scenarios ngr_containsString:self.scenario];
}

# pragma mark - Overwritten methods

- (NSString *)description {
    NSString *scenarios = [self.scenarios componentsJoinedByString:@","];
    return [NSString stringWithFormat:@"<%@: %p, property name: %@, scenario: %@, scenarios(%lu): %@, rules(%lu): %@>", NSStringFromClass([self class]), self, self.property, self.scenario, (unsigned long)[self.scenarios count], scenarios, (unsigned long)[self.validationRules count], [self validatorsDescription]];
}

- (NSString *)validatorsDescription {
    NSMutableString *validators = [NSMutableString string];
    
    for (NGRValidationRule *rule in self.validationRules) {
        NSInteger index = [self.validationRules indexOfObject:rule];
        if (index == [self.validationRules count] - 1) {
            [validators appendFormat:@"%@", rule.name];
        } else {
            [validators appendFormat:@"%@, ", rule.name];
        }
    }
    return [validators copy];
}

@end
