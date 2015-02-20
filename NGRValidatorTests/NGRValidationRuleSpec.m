//
//  NGRValidationRuleSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 20.02.2015.
//
//

SpecBegin(NGRValidationRuleSpec)

describe(@"NGRValidationRule", ^{
    
    __block NGRValidationRule *sut;
    
    context(@"when initialized", ^{
        
        beforeEach(^{
            sut = [[NGRValidationRule alloc] initWithName:@"Fixture Name" block:^NGRError(id value) {
                return (NGRError)value;
            }];
        });
        
        afterEach(^{
            sut = nil;
        });
        
        it(@"should have proper name.", ^{
            expect(sut.name).to.equal(@"Fixture Name");
        });
        
        it(@"when expected value is given, should block return expected value.", ^{
            expect(sut.validationBlock(NGRErrorNoone)).to.equal(NGRErrorNoone);
        });
        
        it(@"when other value than expected is given, should block return expected value.", ^{
            expect(sut.validationBlock(NGRErrorNoone)).toNot.equal(NGRErrorTooBig);
        });
    });
});

SpecEnd
