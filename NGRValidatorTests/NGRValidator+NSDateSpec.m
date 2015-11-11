//
//  NGRValidator+NSDateSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

SpecBegin(NGRValidator_NSDate)

describe(@"NSDate validation", ^{
    
    __block NSDate *date1;
    __block NSDate *date2;
    
    beforeEach(^{
        date1 = [NSDate date];
        date2 = [NSDate dateWithTimeIntervalSinceNow:10];
    });
    
    testDescriptor(@"earlierThan validator", @"2 correct dates", @"2 incorrect dates");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(date1, date2, 1, ^(NGRPropertyValidator *validator) {
            return validator.earlierThan(date2).msgNotEarlierThan(msg);
        });
    });
    
    testDescriptor(@"laterThan validator", @"2 correct dates", @"2 incorrect dates");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(date2, date1, 1, ^(NGRPropertyValidator *validator) {
            return validator.laterThan(date1).msgNotLaterThan(msg);
        });
    });
    
    testDescriptor(@"earlierThanOrEqualTo validator", @"2 correct dates", @"2 incorrect dates");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(date1, date2, 1, ^(NGRPropertyValidator *validator) {
            return validator.earlierThanOrEqualTo(date1).msgNotEarlierThanOrEqualTo(msg);
        });
    });
    
    testDescriptor(@"laterThanOrEqualTo validator", @"2 correct dates", @"2 incorrect dates");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(date2, date1, 1, ^(NGRPropertyValidator *validator) {
            return validator.laterThanOrEqualTo(date2).msgNotLaterThanOrEqualTo(msg);
        });
    });
    
    testDescriptor(@"betweenDates inclusive validator", @"2 correct dates", @"2 incorrect dates");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(date1, date2, 1, ^(NGRPropertyValidator *validator) {
            return validator.betweenDates([NSDate dateWithTimeIntervalSinceNow:-10], date1, YES).msgNotBetweenDates(msg);
        });
    });
    
    testDescriptor(@"betweenDates exclusive validator", @"2 correct dates", @"2 incorrect dates");
    itShouldBehaveLike(NGRValueBehavior, ^{
        return wrapData(date1, date2, 1, ^(NGRPropertyValidator *validator) {
            return validator.betweenDates([NSDate dateWithTimeIntervalSinceNow:-10], date2, NO).msgNotBetweenDates(msg);
        });
    });
});

SpecEnd
