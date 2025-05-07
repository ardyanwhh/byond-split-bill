//
//  LocalizedText.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation

extension String {
    
    enum LocalizedText: String {
        
        case splashFooter = "splash.footer"
    }
    
    static func apply(localizedWithName name: LocalizedText) -> String {
        NSLocalizedString(name.rawValue, comment: "")
    }
}

