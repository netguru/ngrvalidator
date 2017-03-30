//
//  NGRTestModelsSwift.swift
//  NGRValidator
//

import Foundation

enum TestEnum: String {
    case First, Second
}

struct TestStruct {
    let stringProperty: String
    let intProperty: Int
    
    init() {
        stringProperty = "Test"
        intProperty = 100
    }
}

class TestClass {
    let stringProperty: String
    let intProperty: Int
    
    init() {
        stringProperty = "Test"
        intProperty = 100
    }
}
