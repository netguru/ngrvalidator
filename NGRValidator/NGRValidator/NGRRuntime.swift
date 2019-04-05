//
//  NGRRuntime.swift
//  NGRValidator
//

import Foundation

@objc internal final class NGRRuntimeInspector: NSObject {
    
    private let model: Any
    
    private var mirror: Mirror {
        return Mirror(reflecting: model)
    }
    
    public init(model: Any) {
        self.model = model
    }
    
    public func properties() -> [String] {
        return mirror.properties()
    }
    
    public func value(withKey key: String) -> Any? {
        return mirror.value(forKey: key)
    }
    
    public func isClassOrStruct() -> Bool {
        switch mirror.displayStyle {
        case .some(.struct), .some(.class):
            return true
        default:
            return false
        }
    }
}

fileprivate extension Mirror {
    func value(forKey key: String) -> Any? {
        if let value = children.filter({ $0.label == key }).first?.value {
            return value
        }
        
        return superclassMirror?.value(forKey: key)
    }
    
    func properties() -> [String] {
        let childProperties = children.compactMap { $0.label }
        let superProperties = superclassMirror?.properties() ?? []
        
        return [childProperties, superProperties].flatMap { $0 }
    }
}
