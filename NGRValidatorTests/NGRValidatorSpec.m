//
//  NGRValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

typedef NSDictionary * (^NGRDataWrapper)(NGRTestModel *, NSArray *(^)());

// data keys:
NSString *const NGRPropertyValidatorKey = @"NGRPropertyValidatorKey";
NSString *const NGRModelKey = @"NGRModelKey";
NSString *const NGRRulesKey = @"NGRRulesKey";

// behaviours:
NSString *const NGRSuccessBehaviour = @"NGRSuccessBehaviour";
NSString *const NGRFailureBehaviour = @"NGRFailureBehaviour";
NSString *const NGRAssertBehaviour = @"NGRAssertBehaviour";

SharedExamplesBegin(NGRValidatorSharedExamples)

sharedExamplesFor(NGRSuccessBehaviour, ^(NSDictionary *data) {
    
    __block NSError *error = nil;
    __block NSArray *array = nil;
    __block BOOL success = NO;
    
    afterEach(^{
        error = nil; array = nil; success = NO;
    });
    
    it(@"should succeed.", ^{
        success = [NGRValidator validateModel:data[NGRModelKey] error:&error usingRules:data[NGRRulesKey]];
        expect(success).to.beTruthy();
        expect(error).to.beNil();
    });
    
    it(@"should succeed.", ^{
        array = [NGRValidator validateModel:data[NGRModelKey] usingRules:data[NGRRulesKey]];
        expect(array).to.beNil();
    });
});

sharedExamplesFor(NGRFailureBehaviour, ^(NSDictionary *data) {
    
    __block NSError *error = nil;
    __block NSArray *array = nil;
    __block BOOL success = NO;
    
    afterEach(^{
        error = nil; array = nil; success = NO;
    });
    
    it(@"should fail.", ^{
        success = [NGRValidator validateModel:data[NGRModelKey] error:&error usingRules:data[NGRRulesKey]];
        expect(success).to.beFalsy();
        expect(error).toNot.beNil();
    });
    
    it(@"should fail.", ^{
        array = [NGRValidator validateModel:data[NGRModelKey] usingRules:data[NGRRulesKey]];
        expect(array).to.haveCountOf(1);
    });
});

sharedExamplesFor(NGRAssertBehaviour, ^(NSDictionary *data) {
    
    it(@"should raise an exception.", ^{
        expect(^{
            [NGRValidator validateModel:data[NGRModelKey] error:NULL usingRules:data[NGRRulesKey]];
        }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should raise an exception.", ^{
        expect(^{
            [NGRValidator validateModel:data[NGRModelKey] usingRules:data[NGRRulesKey]];
        }).to.raise(NSInternalInconsistencyException);
    });
});

SharedExamplesEnd

SpecBegin(NGRValidatorSpec)

describe(@"NGRValidator", ^{
    
    NGRDataWrapper wrapData = ^(NGRTestModel *model, NSArray *(^rules)()) {
        return @{NGRRulesKey : rules,
                 NGRModelKey : model};;
    };
    
    __block NGRTestModel *model;

    beforeEach(^{
        model = [[NGRTestModel alloc] init];
    });
    
    afterEach(^{
        model = nil;
    });
    
    itShouldBehaveLike(NGRSuccessBehaviour, ^{
        model.string = @"example@example.com";

        return wrapData(model, ^() {
            return @[NGRValidate(@"string").required()];
        });
    });
    
    itShouldBehaveLike(NGRSuccessBehaviour, ^{
        model.string = @"example@example.com";
        
        return wrapData(model, ^() {
            return @[NGRValidate(@"foo").required()];
        });
    });
    
    itShouldBehaveLike(NGRFailureBehaviour, ^{
        return wrapData(model, ^() {
            return @[NGRValidate(@"string").required()];
        });
    });
    
    itShouldBehaveLike(NGRAssertBehaviour, ^{
        model.anID = @10;

        return wrapData(model, ^() {
            return @[NGRValidate(@"anID").required().decimal()];
        });
    });
});

SpecEnd
