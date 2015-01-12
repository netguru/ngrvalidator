//
//  NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//
//

#import "NGRValidator.h"
#import "NSArray+NGRValidator.h"
#import "NSObject+NGRRuntime.h"
#import "NSArray+NGRValidator.h"

@interface NGRValidator ()

@property (strong, nonatomic) NSMutableArray *validators;

@end

@implementation NGRValidator

inline NGRPropertyValidator * NGRValidate(NSString *property) {
    return [NGRPropertyValidator validatorForProperty:property];
}

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        _validators = [NSMutableArray array];
    }
    return self;
}

+ (NGRValidator *)validator {
    return [[[self class] alloc] init];
}

#pragma mark - Public Methods

+ (NSError *)validateValue:(NSObject *)value named:(NSString *)name usingRules:(void (^)(NGRPropertyValidator *validator))rules {
    
    NGRPropertyValidator *propertyValidator = [NGRPropertyValidator validatorForProperty:name];
    if (rules != NULL) rules(propertyValidator);
    return [propertyValidator simpleValidationOfValue:value];
}

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules {
    
    NSError *validationError = [self validateModel:model usingRules:rules scenario:scenario returnTypeClass:[NSError class]];
    if (validationError && *error == NULL) {
        *error = validationError;
        return NO;
    }
    return YES;
}

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error usingRules:(NSArray *(^)())rules {
    return [self validateModel:model error:error scenario:nil usingRules:rules];
}

+ (NSArray *)validateModel:(NSObject *)model scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules {
    NSArray *array = [self validateModel:model usingRules:rules scenario:scenario returnTypeClass:[NSArray class]];
    return ([array count] == 0) ? nil : array;
}

+ (NSArray *)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules {
    return [self validateModel:model scenario:nil usingRules:rules];
}

#pragma mark - Private Methods

+ (id)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules scenario:(NSString *)scenario returnTypeClass:(Class)class {
    
    BOOL throwFirstError = NO;
    if (class == [NSArray class]) throwFirstError = NO;
    else if (class == [NSError class]) throwFirstError = YES;
    else NSAssert(NO, @"Allowed class: NSArray or NSError");
    
    NSArray *array = [rules() ngr_sortedArrayByPriority];
    NSArray *properties = [model ngr_properties];
    NSMutableArray *errors = [NSMutableArray array];
    
    if (array.count == 0) {
        NSLog(@"%@", [NSString stringWithFormat:@"Lack of validation rules. Are you sure you don't want to define rules for %@ model", [model class]]);
    }
    
    for (NGRPropertyValidator *validator in array) {
        validator.scenario = scenario;
        
        [self existsPropertyInValidator:validator ofModel:model];
        
        if (![properties ngr_containsString:validator.property]) {
            NSLog(@"Property named '%@' wasn't found in %@ class. Property validation skipped.", validator.property, [model class]);
        } else {
            id value = [model valueForKey:validator.property];
            
            if (throwFirstError) {
                NSError *validationError = [validator simpleValidationOfValue:value];
                if (validationError) {
                    return validationError;
                }
            } else {
                [errors addObjectsFromArray:[validator complexValidationOfValue:value]];
            }
        }
    }
    return throwFirstError ? nil : [errors copy];
}

+ (void)existsPropertyInValidator:(NGRPropertyValidator *)validator ofModel:(NSObject *)model {
    // Tricky part:
    // Compiler doesn't show warnings if any validation block call isn't ended with parentheses
    // Catch an exception and inform user about possible reason
    @try {
        (void)validator.property;
    }
    @catch (NSException *exception) {
        NSAssert(NO, @"An exception did appear during validation of %@ parameter from %@ model. Did you remember to use parentheses in block call?", validator.property, [model class]);
    }
}

@end
