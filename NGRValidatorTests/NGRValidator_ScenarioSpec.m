//
//  NGRValidator_ScenarioSpec.m
//  NGRValidator
//
//  Created by Patryk Kaczmarek on 11.02.2015.
//
//

static NSString *const NGRFirstScenario = @"NGRFirstScenario";
static NSString *const NGRSecondScenario = @"NGRSecondScenario";

SpecBegin(NGRValidator_ScenarioSpec)

describe(@"Scenario", ^{
    
    /** test 1 scenario: **/

    testDescriptor(@"using first scenario when first is given", @"valid value", nil);
    itShouldBehaveLike(NGRScenarioSuccessBehavior, ^{
        return wrapDataWithScenario(@"123456", NGRFirstScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario]);
        });
    });
    
    testDescriptor(@"using second scenario when first is given", @"invalid decimal", nil);
    itShouldBehaveLike(NGRScenarioSuccessBehavior, ^{
        return wrapDataWithScenario(@"foo", NGRSecondScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario]);
        });
    });
    
    testDescriptor(@"using first scenario when first is given", nil, @"invalid decimal");
    itShouldBehaveLike(NGRScenarioFailureBehavior, ^{
        return wrapDataWithScenario(@"foo", NGRFirstScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario]);
        });
    });
    
    /** 2 scenarios are taken into account: **/
    
    testDescriptor(@"using first scenario when first and second are given", @"valid value", nil);
    itShouldBehaveLike(NGRScenarioSuccessBehavior, ^{
        return wrapDataWithScenario(@"123456", NGRFirstScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario, NGRSecondScenario]);
        });
    });
    
    testDescriptor(@"using second scenario when first and second are given", @"valid value", nil);
    itShouldBehaveLike(NGRScenarioSuccessBehavior, ^{
        return wrapDataWithScenario(@"123456", NGRSecondScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario, NGRSecondScenario]);
        });
    });
    
    testDescriptor(@"using first scenario when first and second are given", nil, @"invalid decimal");
    itShouldBehaveLike(NGRScenarioFailureBehavior, ^{
        return wrapDataWithScenario(@"foo", NGRFirstScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario, NGRSecondScenario]);
        });
    });
    
    testDescriptor(@"using second scenario when first and second are given", nil, @"invalid decimal");
    itShouldBehaveLike(NGRScenarioFailureBehavior, ^{
        return wrapDataWithScenario(@"foo", NGRSecondScenario, 1, ^(NGRPropertyValidator *validator) {
            return validator.decimal().msgNotDecimal(msg).onScenarios(@[NGRFirstScenario, NGRSecondScenario]);
        });
    });
});

SpecEnd

