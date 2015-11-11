//
//  NGRPropertyValidator+SugarSyntaxSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 07/04/15.
//
//

SpecBegin(NGRPropertyValidator_SugarSyntax)

describe(@"Sugar syntax", ^{
    
    __block NGRPropertyValidator *sut;
    
    beforeEach(^{
        sut = [[NGRPropertyValidator alloc] initWithProperty:nil];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"when using `is`, should return same property validator.", ^{
        expect(sut.is).to.beIdenticalTo(sut);
    });
    
    it(@"when using `are`, should return same property validator.", ^{
        expect(sut.are).to.beIdenticalTo(sut);
    });
    
    it(@"when using `on`, should return same property validator.", ^{
        expect(sut.on).to.beIdenticalTo(sut);
    });
    
    it(@"when using `has`, should return same property validator.", ^{
        expect(sut.has).to.beIdenticalTo(sut);
    });
    
    it(@"when using `have`, should return same property validator.", ^{
        expect(sut.have).to.beIdenticalTo(sut);
    });
    
    it(@"when using `to`, should return same property validator.", ^{
        expect(sut.to).to.beIdenticalTo(sut);
    });
    
    it(@"when using `toNot`, should return same property validator.", ^{
        expect(sut.toNot).to.beIdenticalTo(sut);
    });
    
    it(@"when using `notTo`, should return same property validator.", ^{
        expect(sut.notTo).to.beIdenticalTo(sut);
    });
    
    it(@"when using `be`, should return same property validator.", ^{
        expect(sut.be).to.beIdenticalTo(sut);
    });
    
    it(@"when using `with`, should return same property validator.", ^{
        expect(sut.with).to.beIdenticalTo(sut);
    });
    
    it(@"when using `should`, should return same property validator.", ^{
        expect(sut.should).to.beIdenticalTo(sut);
    });
});

SpecEnd
