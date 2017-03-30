//
//  NGRRuntimeInspectorSpec.swift
//  NGRValidator
//

import Quick
import Nimble

@testable import NGRValidator

final class NGRRuntimeInspectorSpec: QuickSpec {
    
    override func spec() {
        describe("Runtime inspector") {
            var sut: NGRRuntimeInspector!
            
            context("when inspecting structs") {
                let testStruct = TestStruct()
                
                beforeEach {
                    sut = NGRRuntimeInspector(model: testStruct)
                }
                
                it("should list all the properties") {
                    let properties = sut.properties()
                    expect(properties).to(haveCount(2))
                    expect(properties).to(contain(["stringProperty","intProperty"]))
                }
                
                it("should provide value based on property string") {
                    expect(sut.value(withKey: "stringProperty") as? String) == testStruct.stringProperty
                    expect(sut.value(withKey: "intProperty") as? Int) == testStruct.intProperty
                }
                
                it("should recognize that model is class or struct") {
                    expect(sut.isClassOrStruct()).to(beTruthy())
                }
            }
            
            context("when inspecting classes") {
                let testClass = TestClass()
                
                beforeEach {
                    sut = NGRRuntimeInspector(model: testClass)
                }
                
                it("should list all the properties") {
                    let properties = sut.properties()
                    expect(properties).to(haveCount(2))
                    expect(properties).to(contain(["stringProperty","intProperty"]))
                }
                
                it("should provide value based on property string") {
                    expect(sut.value(withKey: "stringProperty") as? String) == testClass.stringProperty
                    expect(sut.value(withKey: "intProperty") as? Int) == testClass.intProperty
                }
                
                it("should recognize that model is class or struct") {
                    expect(sut.isClassOrStruct()).to(beTruthy())
                }
            }
            
            context("when inspecting enums") {
                let testEnum = TestEnum.First
                
                beforeEach {
                    sut = NGRRuntimeInspector(model: testEnum)
                }
                
                it("should recognize that model is not a class or struct") {
                    expect(sut.isClassOrStruct()).to(beFalsy())
                }
            }
        }
    }
}
