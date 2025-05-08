//
//  Common.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit

class Common {
    
    static let shared = Common()
    
    /// Make `UILabel` to a dynamic type.
    ///
    /// The Dynamic Type feature allows users to choose
    /// the size of textual content displayed on the screen. It helps users
    /// who need larger text for better readability.
    /// - parameter label: The label you want to make it dynamic.
    /// - parameter font: Define the font type and size
    /// - parameter kind: Define the `TextStyle`
    func makeDynamic(_ label: UILabel, using font: UIFont, as kind: UIFont.TextStyle) {
        label.font = UIFontMetrics(forTextStyle: kind).scaledFont(for: font)
        label.adjustsFontForContentSizeCategory = true
    }
    
    /// Detect user's device width and adjust content size as necessary.
    ///
    /// Use ternary operator to detect if user's device width is larger
    /// than the defined size.
    /// - Parameters:
    ///   - size: The `size` to compare with user's device width
    ///   - isLargerScreen: `Bool` return value that tells if the defined
    /// size is larger or smaller.
    func adjustContent(withComparison size: CGFloat, isLargerScreen: (Bool) -> Void) {
        let largerScreen = UIScreen.main.bounds.width >= size
        isLargerScreen(largerScreen)
    }
    
    /// Add subview to super window
    /// - Parameter window: a call back if super window is not nil
    func addViewToWindow(window: (UIWindow) -> Void) {
        if let availableWindow = UIApplication.shared.keyWindow {
            window(availableWindow)
        }
    }
    
        /// To calculate how many days in total between 2 different dates
        /// - Parameters:
        ///   - from: input from date in string with format `yyyy-MM-dd`
        ///   - to: input to date in string with format `yyyy-MM-dd`
        /// - Returns: This will return how many days between `from` date to `to` date
    func numberOfDaysBetween(_ from: String, and to: String) -> Int {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fromConverted = dateFormatter.date(from: from) ?? Date()
        let toConverted = dateFormatter.date(from: to) ?? Date()
        
        let fromDate = calendar.startOfDay(for: fromConverted)
        let toDate = calendar.startOfDay(for: toConverted)
        let numberOfDays = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day ?? 0
    }
    
    /// Check if user uses Bahasa language or not
    /// - Parameter isBahasa: a callback, true if user uses Bahasa language
    func isBahasaLanguage(isBahasa: (Bool) -> Void) {
        let lang = UserDefaults.standard.string(forKey: "lang") ?? "id"
        isBahasa(lang == "id")
    }
    
    /// Allow only numeric
    /// - Parameter text: input your string text
    /// - Returns: the output will filter only numeric, other characters will be removed
    func digitsOnly(_ text: String) -> String {
        return text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
