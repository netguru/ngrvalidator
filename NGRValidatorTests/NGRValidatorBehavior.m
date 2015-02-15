//
//  NGRValidatorBehavior.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 13.02.2015.
//
//

@interface NGRTestModel : NSObject
@property (strong, nonatomic) id value;
@end

@implementation NGRTestModel @end

SharedExamplesBegin(CRVAssetTypeBehavior)

sharedExamplesFor(NGRBehavior, ^(NSDictionary *data) {
    
    __block NSError *error; __block NSArray *array; __block BOOL success;
    __block NGRTestModel *model; __block NSArray *(^rules)(); __block NGRPropertyValidator *propertyValidator;
    
    beforeEach(^{
        model = [[NGRTestModel alloc] init];
        rules = ^NSArray *{
            return @[data[NGRValidatorKey]];
        };
        propertyValidator = [rules() firstObject];
    });
    
    afterEach(^{
        model = nil; rules = nil; error = nil; array = nil;
    });
    
    describe(testDescriptor, ^{

        it(@"with valid value, should succeed.", ^{
            
            success = NO;
            model.value = data[NGRValidValueKey];
            
            success = [NGRValidator validateModel:model error:&error usingRules:rules];
            expect(success).to.beTruthy();
            expect(error).to.beNil();
            
            array = [NGRValidator validateModel:model usingRules:rules];
            expect(array).to.beNil();
        });
        
        it(@"with invalid value, should fail.", ^{
            
            success = YES;
            model.value = data[NGRInvalidValueKey];
            
            success = [NGRValidator validateModel:model error:&error usingRules:rules];
            expect(success).to.beFalsy();
            expect(error).toNot.beNil();
            expect(error.localizedDescription).to.contain(msg);
            
            array = [NGRValidator validateModel:model usingRules:rules];
            expect(array).to.haveCountOf([data[NGRErrorCountKey] integerValue]);
            for (NSError *error in array) {
                expect(error.localizedDescription).to.contain(msg);
            }
        });
    });
    
});

SharedExamplesEnd
