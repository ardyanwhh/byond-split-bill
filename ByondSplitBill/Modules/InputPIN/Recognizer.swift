//
//  Recognizer.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit

class NumpadRecognizer: UITapGestureRecognizer {
    var value: String
    var label: UILabel?
    
    init(target: AnyObject?, action: Selector, value: String, label: UILabel?) {
        self.value = value
        self.label = label
        
        super.init(
            target: target, action: action
        )
    }
}
