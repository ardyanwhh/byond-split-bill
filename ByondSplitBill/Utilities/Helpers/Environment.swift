//
//  Environment.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import Foundation

enum Environment {
    
    private enum EnvError: Error {
        case missingKey, invalidValue
    }
    
    static func getValue<T>(forKey key: EnvKey) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            throw EnvError.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw EnvError.invalidValue
        }
    }
    
    enum EnvKey: String {
        
        // base url
        
        case baseURL = "BASE_URL"
    }
}
