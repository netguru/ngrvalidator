//
//  NGRUserStructure.swift
//  NGRValidator
//

import Foundation

struct User {
    
    let name: String
    let password: String
    
    let isAdmin: Bool?
    let birthDate: Date
    let attachment: Data
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
        
        self.isAdmin = true
        self.birthDate = Date()
        self.attachment = Data()
    }
}
