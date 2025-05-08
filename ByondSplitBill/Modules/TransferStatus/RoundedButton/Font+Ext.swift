//
//  Font+Ext.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit

extension UIFont {

    static func bsiBold(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "DMSans-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

    static func bsiBoldItalic(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "DMSans-BoldItalic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
    }

    static func bsiItalic(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "DMSans-Italic", size: size) ?? UIFont.italicSystemFont(ofSize: size)
    }

    static func bsiMedium(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "DMSans-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static func bsiMediumItalic(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "DMSans-MediumItalic", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static func bsiRegular(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "DMSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func bsiAmiriBold(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "Amiri-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

    static func bsiAmiriBoldSlanted(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "Amiri-BoldSlanted", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static func bsiAmiriRegular(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "Amiri-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func bsiAmiriSlanted(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "Amiri-Slanted", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
