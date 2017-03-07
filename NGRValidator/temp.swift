//
//  temp.swift
//  NGRValidator
//
//  Created by Robert Abramczyk on 27/02/2017.
//
//

import Foundation

class Temp {
    
    public func calculateSmth() -> Void {
        let error = NGRValidator.validateValue("robert.abramczyk.1990@gmail.com" as NSObject, named: "Email", rules: { validator in
            validator.is.required().to.have.syntax(0);
        })
    }
    
}
