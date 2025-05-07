//
//  Typography.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

extension UIFont {
    
    enum CustomFontName: String {
        case dmSansRegular = "DMSans-Regular"
        case dmSansMedium = "DMSans-Medium"
        case dmSansBold = "DMSans-Bold"
    }
    
    enum FontSizing: CGFloat {
        case caption2 = 10
        case caption = 12
        case body2 = 14
        case body = 16
        case title3 = 21
        case title2 = 24
        case title = 28
    }
    
    static func apply(fontName name: CustomFontName, size: FontSizing) -> UIFont {
        UIFont(name: name.rawValue, size: size.rawValue)!
    }
}

