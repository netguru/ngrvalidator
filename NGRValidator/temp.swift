//
//  temp.swift
//  NGRValidator
//
//  Created by Robert Abramczyk on 27/02/2017.
//
//

import Foundation

class Temp {
    
    var email: NSString = ""
    
    public func calculateEmail() -> Bool {
        
        let _ = validator.is.required().to.have.syntax(.email)
            
    }
    
}
