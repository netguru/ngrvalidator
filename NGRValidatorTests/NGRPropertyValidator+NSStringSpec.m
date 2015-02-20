//
//  NGRPropertyValidator+NSStringSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 20.02.2015.
//
//

SpecBegin(NGRPropertyValidator_NSStringSpec)

describe(@"NGRPropertyValidator+NSStringSpec", ^{
    
    __block NGRPropertyValidator *sut;
    
    beforeEach(^{
        sut = [NGRPropertyValidator validatorForProperty:@"Fixture Value"];
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
    
    context(@"when add 1 rule", ^{
        
        __block NGRValidationRule *rule;
        
        beforeEach(^{
            sut.minLength(4);
            rule = sut.validationRules.firstObject;
        });
        
        it(@"should have 1 validation rule.", ^{
            expect(sut.validationRules).haveCountOf(1);
        });
        
        it(@"should have proper name.", ^{
            expect(rule.name).to.equal(@"minimum length");
        });
        
        context(@"and perform it", ^{
            
            it(@"with invalid value, should return proper error.", ^{
                expect(rule.validationBlock(@"foo")).to.equal(NGRErrorTooShort);
            });
            
            it(@"with valid value, should return no error.", ^{
                expect(rule.validationBlock(@"foo_bar_baz")).to.equal(NGRErrorNoone);
            });
            
            
        });
    });
});

SpecEnd

