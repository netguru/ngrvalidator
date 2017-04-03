//
//  NGRPropertyValidatorSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRPropertyValidator)

describe(@"NGRPropertyValidator", ^{
    
    __block NGRPropertyValidator *sut;
    
    beforeEach(^{
        sut = [[NGRPropertyValidator alloc] initWithProperty:@"Fixture Value"];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"when initialized, should have proper name.", ^{
        expect(sut.property).to.equal(@"Fixture Value");
    });
    
    it(@"when initialized, should have priority set to default", ^{
        expect(sut.priority).to.equal(100);
    });
    
    it(@"should messages be hooked properly.", ^{
        expect(sut.messages).toNot.beNil();
    });
    
    describe(@"when change order", ^{
        
        beforeEach(^{
            sut.order(90);
        });
        
        it(@"should default order be changed", ^{
            expect(sut.priority).to.equal(90);
        });
    });
    
    describe(@"adding localized name", ^{
        __block NSString *errorDescription;
        
        beforeEach(^{
            sut.is.required().to.have.syntax(NGRSyntaxHTTP);
        });
        
        context(@"when localized name is non null", ^{
            
            
            beforeEach(^{
                sut.localizedName(@"Fixture Localized Name");
                
                NSError *error = [sut simpleValidationOfValue:@"wrong-syntax"];
                errorDescription = error.userInfo[NSLocalizedDescriptionKey];
            });
            
            it(@"error description should start with that name", ^{
                expect(errorDescription).to.beginWith(@"Fixture Localized Name");
            });
        });
        
        context(@"when localized name is null", ^{
            
            beforeEach(^{
                sut.localizedName(NULL);
                
                NSError *error = [sut simpleValidationOfValue:@"wrong-syntax"];
                errorDescription = error.userInfo[NSLocalizedDescriptionKey];
            });
            
            it(@"error description should start with property name", ^{
                expect(errorDescription).to.beginWith(@"Fixture Value");
            });
        });
        
    });
    
    context(@"when add 1 rule", ^{
        
        beforeEach(^{
            sut.minLength(4).msgTooLong(@"Fixture message");
        });
        
        it(@"should have 1 validation rule.", ^{
            expect(sut.validationRules).haveCountOf(1);
        });
        
        it(@"should have proper name for error message.", ^{
            expect([sut.messages messageForKey:MSGTooLong]).to.equal(@"Fixture message");
        });
        
        it(@"should not have any scenario.", ^{
            expect(sut.scenarios).to.beNil();
        });
        
        it(@"should not scenario name be set.", ^{
            expect(sut.scenario).to.beNil();
        });
        
        context(@"with scenario", ^{
            
            beforeEach(^{
                sut.onScenarios(@[@"Fixture scenario"]);
            });
            
            it(@"should have exactly 1 scenario.", ^{
                expect(sut.scenarios).haveCountOf(1);
            });
            
            it(@"should scenario name be set properly.", ^{
                NGRTestModel *model = [[NGRTestModel alloc] init];
                [NGRValidator validateModel:model scenario:sut.scenarios.firstObject delegate:nil rules:^NSArray *{
                    return @[sut];
                }];
                expect(sut.scenario).to.equal(@"Fixture scenario");
            });
            
        });
    });    
});

SpecEnd
