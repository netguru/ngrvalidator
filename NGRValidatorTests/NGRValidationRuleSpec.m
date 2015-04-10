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
            sut = [[NGRValidationRule alloc] initWithName:@"Fixture Name" block:^NGRMsgKey *(NGRMsgKey *value) {
                return value;
            }];
        });
        
        afterEach(^{
            sut = nil;
        });
        
        it(@"should have proper name.", ^{
            expect(sut.name).to.equal(@"Fixture Name");
        });

        it(@"when expected value is given, should block return expected value.", ^{
            expect(sut.validationBlock(@"Fixture Block Parameter")).to.equal(@"Fixture Block Parameter");
        });
    });
});

SpecEnd
