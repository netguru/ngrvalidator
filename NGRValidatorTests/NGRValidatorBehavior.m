//
//  NGRValidatorBehavior.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 13.02.2015.
//
//

#import "NSError+NGRValidator.h"

SharedExamplesBegin(NGRValidatorBehavior)

sharedExamplesFor(NGRMultiplePropertiesBehavior, ^(NSDictionary *data) {
    
    __block NSArray *(^rules)(); __block BOOL success; __block NGRTestModel *model;
    
    beforeEach(^{
        model = data[@"model"];
        success = ((NSNumber *)data[@"success"]).boolValue;
        rules = ^NSArray *{
            return data[@"rules"];
        };
    });
    
    afterEach(^{
        model = nil; rules = nil; cleanDescriptors();
    });
    
    it(validatorDescriptor, ^{
        
        NSError *error; NSArray *array;
        
        // 1st
        BOOL localSuccess = [NGRValidator validateModel:model error:&error delegate:nil rules:rules];
        
        if (success) {
            expect(localSuccess).to.beTruthy();
            expect(error).to.beNil();
        } else {
            expect(localSuccess).to.beFalsy();
            expect(error).toNot.beNil();
        }
        
        // 2nd
        array = [NGRValidator validateModel:model delegate:nil rules:rules];
        
        if (success) {
            expect(array).to.beNil();
        } else {
            expect(array).toNot.beNil();
        }
    });
});

sharedExamplesFor(NGRValueBehavior, ^(NSDictionary *data) {
    
    __block NSError *error; __block NSArray *array; __block BOOL success;
    __block NGRTestModel *model; __block NSArray *(^rules)(); __block NGRPropertyValidator *propertyValidator;
    
    beforeEach(^{
        model = [[NGRTestModel alloc] init];
        propertyValidator = data[NGRValidatorKey];
        rules = ^NSArray *{
            return @[propertyValidator];
        };
    });
    
    afterEach(^{
        model = nil; rules = nil; error = nil; array = nil; cleanDescriptors();
    });
    
    describe(validatorDescriptor, ^{

        it([NSString stringWithFormat:@"with %@, should succeed.", successDescriptor], ^{
            
            success = NO;
            model.value = data[NGRValidValueKey];
            
            if ([model.value isKindOfClass:[NSString class]] && [model.value isEqualToString:NGRSKIP]) {
                return;
            }
            
            // 1st
            success = [NGRValidator validateModel:model error:&error delegate:nil rules:rules];
            expect(success).to.beTruthy();
            expect(error).to.beNil();
            
            // 2nd
            array = [NGRValidator validateModel:model delegate:nil rules:rules];
            expect(array).to.beNil();
            
            // 3rd
            error = nil;
            error = [NGRValidator validateValue:model.value named:@"value" rules:^(NGRPropertyValidator *validator) {
                [validator setValue:propertyValidator.validationRules forKey:@"validationRules"];
                [validator setValue:propertyValidator.messages forKey:@"messages"];
            }];
            expect(error).to.beNil();
        });
        
        it([NSString stringWithFormat:@"with %@, should fail.", failureDescriptor], ^{
            
            success = YES;
            model.value = data[NGRInvalidValueKey];
            
            if ([model.value isKindOfClass:[NSString class]] && [model.value isEqualToString:NGRSKIP]) {
                return;
            }
            
            // 1st
            success = [NGRValidator validateModel:model error:&error delegate:nil rules:rules];
            expect(success).to.beFalsy();
            expect(error).toNot.beNil();
            expect(error.localizedDescription).to.contain(msg);
            expect(error.userInfo[NGRValidatorPropertyNameKey]).to.equal(@"value");
            
            // 2nd
            array = [NGRValidator validateModel:model delegate:nil rules:rules];
            expect(array).to.haveCountOf([data[NGRErrorCountKey] integerValue]);
            for (NSError *error in array) {
                expect(error.localizedDescription).to.contain(msg);
            }
            
            // 3rd
            error = nil;
            error = [NGRValidator validateValue:model.value named:@"value" rules:^(NGRPropertyValidator *validator) {
                [validator setValue:propertyValidator.validationRules forKey:@"validationRules"];
                [validator setValue:propertyValidator.messages forKey:@"messages"];
            }];
            expect(error).toNot.beNil();
            expect(error.localizedDescription).to.contain(msg);
        });
    });
});

sharedExamplesFor(NGRScenarioSuccessBehavior, ^(NSDictionary *data) {
    
    __block NSError *error; __block NSArray *array; __block BOOL success;
    __block NGRTestModel *model; __block NSArray *(^rules)(); __block NGRPropertyValidator *propertyValidator;
    __block NSString *scenario;
    
    beforeEach(^{
        scenario = data[NGRScenarioKey];
        model = [[NGRTestModel alloc] init];
        propertyValidator = data[NGRValidatorKey];
        rules = ^NSArray *{
            return @[propertyValidator];
        };
    });
    
    afterEach(^{
        model = nil; rules = nil; error = nil; array = nil; scenario = nil; cleanDescriptors();
    });
    
    describe(validatorDescriptor, ^{
        
        it([NSString stringWithFormat:@"with %@, should succeed.", successDescriptor], ^{
            
            success = NO;
            model.value = data[NGRValidValueKey];
            
            // 1st
            success = [NGRValidator validateModel:model error:&error scenario:scenario delegate:nil rules:rules];
            expect(success).to.beTruthy();
            expect(error).to.beNil();
            
            // 2nd
            array = [NGRValidator validateModel:model scenario:scenario delegate:nil rules:rules];
            expect(array).to.beNil();
        });
    });
});

sharedExamplesFor(NGRScenarioFailureBehavior, ^(NSDictionary *data) {
    
    __block NSError *error; __block NSArray *array; __block BOOL success;
    __block NGRTestModel *model; __block NSArray *(^rules)(); __block NGRPropertyValidator *propertyValidator;
    __block NSString *scenario;
    
    beforeEach(^{
        scenario = data[NGRScenarioKey];
        model = [[NGRTestModel alloc] init];
        propertyValidator = data[NGRValidatorKey];
        rules = ^NSArray *{
            return @[propertyValidator];
        };
    });
    
    afterEach(^{
        model = nil; rules = nil; error = nil; array = nil; scenario = nil; cleanDescriptors();
    });
    
    describe(validatorDescriptor, ^{
    
        it([NSString stringWithFormat:@"with %@, should fail.", failureDescriptor], ^{
            
            success = YES;
            model.value = data[NGRValidValueKey];
            
            // 1st
            success = [NGRValidator validateModel:model error:&error scenario:scenario delegate:nil rules:rules];
            expect(success).to.beFalsy();
            expect(error).toNot.beNil();
            expect(error.localizedDescription).to.contain(msg);
            expect(error.userInfo[NGRValidatorPropertyNameKey]).to.equal(@"value");
            
            // 2nd
            array = [NGRValidator validateModel:model scenario:scenario delegate:nil rules:rules];
            expect(array).to.haveCountOf([data[NGRErrorCountKey] integerValue]);
            for (NSError *error in array) {
                expect(error.localizedDescription).to.contain(msg);
            }
        });
    });
});

sharedExamplesFor(NGRAssertBehavior, ^(NSDictionary *data) {
    
    __block NSError *error; __block NSArray *(^rules)();
    __block NGRTestModel *model; __block NGRPropertyValidator *propertyValidator;
    
    beforeEach(^{
        model = [[NGRTestModel alloc] init];
        model.value = data[NGRValidValueKey];
        propertyValidator = data[NGRValidatorKey];
        rules = ^NSArray *{
            return @[propertyValidator];
        };
    });
    
    afterEach(^{
        model = nil; rules = nil; error = nil; cleanDescriptors();
    });
        
    it(failureDescriptor, ^{
        expect(^{
            [NGRValidator validateModel:model error:&error delegate:nil rules:rules];
        }).to.raise(NSInternalInconsistencyException);
        
        expect(^{
            [NGRValidator validateModel:model delegate:nil rules:rules];
        }).to.raise(NSInternalInconsistencyException);
        
        expect(^{
            [NGRValidator validateValue:model.value named:nil rules:^(NGRPropertyValidator *validator) {
                [validator setValue:propertyValidator.validationRules forKey:@"validationRules"];
                [validator setValue:propertyValidator.messages forKey:@"messages"];
            }];
        }).to.raise(NSInternalInconsistencyException);
    });
});

SharedExamplesEnd
