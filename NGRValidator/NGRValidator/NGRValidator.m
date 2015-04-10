//
//  NGRValidator.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 23.12.2014.
//

#import "NGRValidator.h"

#import "NSArray+NGRValidator.h"
#import "NSObject+NGRRuntime.h"

@implementation NGRValidator

#pragma mark - Public

+ (NSError *)validateValue:(NSObject *)value named:(NSString *)name rules:(void (^)(NGRPropertyValidator *validator))rules {
    
    if (rules == NULL) {
        return nil;
    }
    
    NGRPropertyValidator *propertyValidator = [[NGRPropertyValidator alloc] initWithProperty:name];
    rules(propertyValidator);
    return [propertyValidator simpleValidationOfValue:value];
}

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error scenario:(NSString *)scenario delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules {
    
    if (rules == NULL) {
        return NO;
    }
    
    NSError *validationError = [self validateModel:model tillFirstError:YES delegate:delegate rules:rules scenario:scenario];
    if (validationError) {
        if (error && *error == NULL) {
            *error = validationError;
        }
        return NO;
    }
    return YES;
}

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules {
    return [self validateModel:model error:error scenario:nil delegate:delegate rules:rules];
}

+ (NSArray *)validateModel:(NSObject *)model scenario:(NSString *)scenario delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules {
    
    if (rules == NULL) {
        return nil;
    }
    
    NSArray *array = [self validateModel:model tillFirstError:NO delegate:delegate rules:rules scenario:scenario];
    return ([array count] == 0) ? nil : array;
}

+ (NSArray *)validateModel:(NSObject *)model delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules {
    return [self validateModel:model scenario:nil delegate:delegate rules:rules];
}

#pragma mark - Private

+ (id)validateModel:(NSObject *)model tillFirstError:(BOOL)tillFirstError delegate:(id<NGRMessaging>)delegate rules:(NGRRules)rules scenario:(NSString *)scenario {
    
    NSArray *array = [rules() ngr_sortedArrayByPriority];
    NSArray *properties = [model ngr_properties];
    NSMutableArray *errors = [NSMutableArray array];
    
    if (array.count == 0) {
        NSLog(@"%@", [NSString stringWithFormat:@"Lack of validation rules in %@ model. Validation couldn't be processed.", [model class]]);
    }
    
    for (NGRPropertyValidator *validator in array) {
        validator.scenario = scenario;
        validator.delegate = delegate;
        
        [self checkPresenceOfPropertyInValidator:validator model:model];
        
        if (![properties ngr_containsString:validator.property]) {
            NSLog(@"Property named '%@' wasn't found in %@ class. Property validation skipped.", validator.property, [model class]);
        } else {
            id value = [model valueForKey:validator.property];
            
            if (tillFirstError) {
                NSError *validationError = [validator simpleValidationOfValue:value];
                if (validationError) {
                    return validationError;
                }
            } else {
                [errors addObjectsFromArray:[validator complexValidationOfValue:value]];
            }
        }
    }
    return tillFirstError ? nil : [errors copy];
}

+ (void)checkPresenceOfPropertyInValidator:(NGRPropertyValidator *)validator model:(NSObject *)model {
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

@implementation NGRValidator (Deprecated)

+ (NSError *)validateValue:(NSObject *)value named:(NSString *)name usingRules:(void (^)(NGRPropertyValidator *validator))rules {
    return [self validateValue:value named:name rules:rules];
}

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error usingRules:(NSArray *(^)())rules {
    return [self validateModel:model error:error delegate:nil rules:rules];
}

+ (BOOL)validateModel:(NSObject *)model error:(NSError **)error scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules {
    return [self validateModel:model error:error scenario:scenario delegate:nil rules:rules];
}

+ (NSArray *)validateModel:(NSObject *)model usingRules:(NSArray *(^)())rules {
    return [self validateModel:model delegate:nil rules:rules];
}

+ (NSArray *)validateModel:(NSObject *)model scenario:(NSString *)scenario usingRules:(NSArray *(^)())rules {
    return [self validateModel:model scenario:scenario delegate:nil rules:rules];
}

@end
