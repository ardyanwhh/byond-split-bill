//
//  InputPINEntity.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation

struct InputPIN {
    
}

enum InputPinIcon: String {
    case ICONKEY = "icon-key"
    case ICONPINGREY = "icon-pin-grey"
    case ICONPINRED = "icon-pin-red"
    case ICONVALIDPIN = "icon-valid-pin"
    
    func value() -> String {
        return self.rawValue
    }
}
