//
//  NGRValidator+SwiftSpec.swift
//  NGRValidator
//

import Quick
import Nimble

@testable import NGRValidator

final class NGRValidatorSwiftSpec: QuickSpec {
    
    final class MockedMessagingDelegate: NSObject, NGRMessaging {
        var validationErrorMessagesByPropertyKeyWasCalled: Bool = false
        
        func validationErrorMessagesByPropertyKey() -> [AnyHashable : Any] {
            validationErrorMessagesByPropertyKeyWasCalled = true
            return [:]
        }
    }
    
    override func spec() {
        describe("Swift Interface") {
            var errors: [Error]!
            let testStruct = TestStruct()
            
            context("when validating struct results in error") {
                
                context("and scenario was not provided") {
                    let delegate = MockedMessagingDelegate()
                    
                    beforeEach {
                        errors = NGRValidator.validate(model: testStruct, tillFirstError: false, delegate: delegate) { () -> [NGRPropertyValidator]? in
                            return [NGRPropertyValidator(property: "stringProperty")!.to.have.syntax(.HTTP)]
                        }
                    }
                    
                    it("should result in one error") {
                        expect(errors).to(haveCount(1))
                    }
                    
                    it("should call delegate methods") {
                        expect(delegate.validationErrorMessagesByPropertyKeyWasCalled).to(beTruthy())
                    }
                }
                
                context("and scenario was provided") {
                    let delegate = MockedMessagingDelegate()
                    
                    beforeEach {
                        let testScenario = "TestScenario"
                        
                        errors = NGRValidator.validate(model: testStruct, tillFirstError: false, delegate: delegate, scenario: testScenario) { () -> [NGRPropertyValidator]? in
                            return [NGRPropertyValidator(property: "stringProperty")!.to.have.syntax(.HTTP).onScenarios([testScenario])]
                        }
                    }
                    
                    it("should result in one error") {
                        expect(errors).to(haveCount(1))
                    }
                    
                    it("should call delegate methods") {
                        expect(delegate.validationErrorMessagesByPropertyKeyWasCalled).to(beTruthy())
                    }
                }
            }
            
            context("when validating struct results in success") {
                let delegate = MockedMessagingDelegate()
                
                beforeEach {
                    let testScenario = "TestScenario"
                    
                    errors = NGRValidator.validate(model: testStruct, tillFirstError: false, delegate: delegate, scenario: testScenario) { () -> [NGRPropertyValidator]? in
                        return [NGRPropertyValidator(property: "stringProperty")!.to.have.syntax(.name).onScenarios([testScenario])]
                    }
                }
                
                it("should result in no errors") {
                    expect(errors).to(haveCount(0))
                }
                
                it("should not call delegate methods") {
                    expect(delegate.validationErrorMessagesByPropertyKeyWasCalled).to(beFalsy())
                }

            }
        }
    }
}



