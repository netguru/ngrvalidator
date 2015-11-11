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
#import "NSError+NGRValidator.h"

NSUInteger const NGRPropertyValidatorDefaultPriority = 100;
NGRMsgKey *const NGRErrorUnexpectedClass = (NGRMsgKey *)@"NGRErrorUnexpectedClass";

@interface NGRPropertyValidator ()

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

#pragma mark - Public

- (NSError *)simpleValidationOfValue:(id)value {
    return [self validateValue:value usingSimpleValidation:YES];
}

- (NSArray *)complexValidationOfValue:(id)value {
    return [self validateValue:value usingSimpleValidation:NO];
}

- (void)validateClass:(Class)aClass withName:(NSString *)name validationBlock:(NGRValidationBlock)block {
    __weak typeof(self) weakSelf = self;

    [self addValidatonBlockWithName:name block:^NGRMsgKey *(id value) {
        
        BOOL isValueAllowedToBeEmpty = weakSelf.allowEmptyProperty && [value ngr_isCountable] && [value ngr_isEmpty];
        BOOL doesValueExistAndIsNotRequired = !weakSelf.isRequired && !value;
        
        if (value && aClass && ![value isKindOfClass:aClass]) {
            return NGRErrorUnexpectedClass;
        } else if (isValueAllowedToBeEmpty || doesValueExistAndIsNotRequired) {
            return nil;
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
        [self validateClass:nil withName:@"required" validationBlock:^NGRMsgKey *(id value) {
            
            BOOL doesValueExist = value && ![value isKindOfClass:[NSNull class]];
            if (!doesValueExist || [value ngr_isEmpty]) {
                return MSGNil;
            }
            return nil;
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

#pragma mark - Private

- (id)validateValue:(id)value usingSimpleValidation:(BOOL)simpleValidation {
    
    if (![self shouldValidate]) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NGRValidationRule *validationRule in self.validationRules) {
        
        NGRMsgKey *errorKey = validationRule.validationBlock(value);
        
        if ([errorKey isEqualToString:NGRErrorUnexpectedClass]) {
            NSAssert(NO, @"Value \"%@\" for \"%@\" parameter is wrong kind of class", value, self.property);
            
        } else if (errorKey) {
            if (simpleValidation) {
                return [self errorWithErrorKey:errorKey];
            } else {
                [array addObject:[self errorWithErrorKey:errorKey]];
            }
        }
    }
    return simpleValidation ? nil : [array copy];
}

- (void)addValidatonBlockWithName:(NSString *)name block:(NGRMsgKey *(^)(id))block {
    
    NGRValidationRule *validatorRule = [[NGRValidationRule alloc] initWithName:name block:block];
    [self.validationRules addObject:validatorRule];
}

- (NSError *)errorWithErrorKey:(NGRMsgKey *)key {
    
    NSDictionary *messages;
    if ([self.delegate respondsToSelector:@selector(validationErrorMessagesByPropertyKey)]) {
        messages = [self.delegate validationErrorMessagesByPropertyKey];
    }
    
    NSString *customDescription = messages[self.property][key];
    if (customDescription) {
        return [NSError ngr_errorWithDescription:customDescription propertyName:self.property];
    }
    
    NSString *property = self.property ?: @"Validated property";
    NSString *propertyName = (self.localizedPropertyName) ?: [property ngr_stringByCapitalizeFirstLetter];
    NSString *space = propertyName.length > 0 ? @" " : @"";
    NSString *description = [NSString stringWithFormat:@"%@%@%@", propertyName, space, [self.messages messageForKey:key]];
    return [NSError ngr_errorWithDescription:description propertyName:self.property];
}

- (BOOL)shouldValidate {
    if (!self.scenarios || !self.scenario) {
        return YES;
    }
    //only reached when self.scenario && self.scenarios:
    return [self.scenarios ngr_containsString:self.scenario];
}

#pragma mark - Debugging

- (NSString *)description {
    NSString *scenarios = [self.scenarios componentsJoinedByString:@","];
    return [NSString stringWithFormat:@"<%@: %p, property name: %@, scenario: %@, scenarios(%lu): %@, rules(%lu): %@>", NSStringFromClass([self class]), self, self.property, self.scenario, (unsigned long)[self.scenarios count], scenarios, (unsigned long)[self.validationRules count], [self validatorsDescription]];
}

- (NSString *)validatorsDescription {
    NSMutableString *validators = [NSMutableString string];
    
    for (NGRValidationRule *rule in self.validationRules) {
        BOOL isLastRule = [rule isEqual:self.validationRules.lastObject];
        [validators appendFormat:@"%@%@", rule.name, isLastRule ? @"" : @", "];
    }
    return [validators copy];
}

@end
