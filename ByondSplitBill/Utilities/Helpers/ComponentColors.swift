//
//  ComponentColors.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: String, alpha: CGFloat? = nil) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let length = hexSanitized.count
        switch length {
        case 6: // RGB (e.g., "#RRGGBB")
            let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(rgb & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: alpha ?? 1.0)
        case 8: // RGBA (e.g., "#RRGGBBAA")
            let r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            let g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            let b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            let a = CGFloat(rgb & 0x000000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)
        default:
            return nil
        }
    }
    
    static let primaryGreen           = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.6980392157, alpha: 1) /* Hex Color: #00BFB2 */
    static let primaryGreen2          = #colorLiteral(red: 0, green: 0.6784313725, blue: 0.6901960784, alpha: 1) /* Hex Color: #00ADB0 */
    static let primaryGreen3          = #colorLiteral(red: 0, green: 0.7803921569, blue: 0.7450980392, alpha: 1) /* Hex Color: #00C7BE */
    static let primaryGreen900        = #colorLiteral(red: 0, green: 0.2901960784, blue: 0.2549019608, alpha: 1) /* Hex Color: #004A41 */
    static let primaryGreen700        = #colorLiteral(red: 0, green: 0.462745098, blue: 0.4274509804, alpha: 1) /* Hex Color: #00766D */
    static let primaryGreen500        = #colorLiteral(red: 0, green: 0.5098039216, blue: 0.4941176471, alpha: 1) /* Hex Color: #00827E */
    static let primaryGreen200        = #colorLiteral(red: 0.5490196078, green: 0.7803921569, blue: 0.7764705882, alpha: 1) /* Hex Color: #8CC7C6 */
    static let primaryGreen50         = #colorLiteral(red: 0.8862745098, green: 0.9411764706, blue: 0.9490196078, alpha: 1) /* Hex Color: #E2F0F2 */
    
    static let primaryYellow          = #colorLiteral(red: 0.9490196078, green: 0.7058823529, blue: 0.2549019608, alpha: 1) /* Hex Color: #F2B441 */
    static let primaryYellow2         = #colorLiteral(red: 1, green: 0.6, blue: 0, alpha: 1) /* Hex Color: #FF9900 */
    static let primaryYellow3         = #colorLiteral(red: 0.9450980392, green: 0.7058823529, blue: 0.2039215686, alpha: 1) /* Hex Color: #F1B434 */
    static let primaryYellow900       = #colorLiteral(red: 0.8941176471, green: 0.5411764706, blue: 0.2666666667, alpha: 1) /* Hex Color: #E48A44 */
    static let primaryYellow700       = #colorLiteral(red: 0.8941176471, green: 0.5411764706, blue: 0.2666666667, alpha: 1) /* Hex Color: #ED8B00 */
    static let primaryYellow500       = #colorLiteral(red: 0.9647058824, green: 0.9019607843, blue: 0.4039215686, alpha: 1) /* Hex Color: #F6E667 */
    static let primaryYellow200       = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.6784313725, alpha: 1) /* Hex Color: #FDF4AD */
    static let primaryYellow100       = #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9019607843, alpha: 1) /* Hex Color: #FFF5E6 */
    static let primaryYellow50        = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.9215686275, alpha: 1) /* Hex Color: #FFFDEB */
    
    static let accentBlue             = #colorLiteral(red: 0, green: 0.2784313725, blue: 0.7333333333, alpha: 1) /* Hex Color: #0047BB */
    
    static let primaryGrey            = #colorLiteral(red: 0.5333333333, green: 0.5450980392, blue: 0.5529411765, alpha: 1) /* Hex Color: #888B8D */
    static let primaryGrey2           = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1) /* Hex Color: #E0E0E0 */
    static let primaryGrey3           = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) /* Hex Color: #F0F0F0 */
    static let primaryGrey4           = #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1) /* Hex Color: #616161 */
    
    static let secondaryPurple        = #colorLiteral(red: 0.5568627451, green: 0.3843137255, blue: 0.7019607843, alpha: 1) /* Hex Color: #8E62B3 */
    static let secondaryBlue          = #colorLiteral(red: 0.3137254902, green: 0.6196078431, blue: 0.8980392157, alpha: 1) /* Hex Color: #509EE5 */
    static let secondaryRed           = #colorLiteral(red: 0.8980392157, green: 0.3450980392, blue: 0.3137254902, alpha: 1) /* Hex Color: #E55850 */
    static let secondaryPink          = #colorLiteral(red: 0.937254902, green: 0.6941176471, blue: 0.6392156863, alpha: 1) /* Hex Color: #EFB1A3 */
    static let secondaryCream         = #colorLiteral(red: 0.9647058824, green: 0.9607843137, blue: 0.9411764706, alpha: 1) /* Hex Color: #F6F5F0 */
    
    static let textBlack100           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.96) /* Hex Color: #000000 Opacity 96% */
    static let textBlack80            = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.62) /* Hex Color: #000000 Opacity 62% */
    static let textBlack60            = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38) /* Hex Color: #000000 Opacity 38% */
    static let textBlack40            = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12) /* Hex Color: #000000 Opacity 12% */
    static let textRed                = #colorLiteral(red: 0.8431372549, green: 0.2549019608, blue: 0.2666666667, alpha: 1) /* Hex Color: #D74144 */
    static let textGreen              = #colorLiteral(red: 0.4196078431, green: 0.7411764706, blue: 0.3294117647, alpha: 1) /* Hex Color: #6BBD54 */
    
    static let successGreen           = #colorLiteral(red: 0.007843137255, green: 0.7450980392, blue: 0.1254901961, alpha: 1) /* Hex Color: #02BE20 */
    static let errorRed               = #colorLiteral(red: 0.7803921569, green: 0.06666666667, blue: 0.2784313725, alpha: 1) /* Hex Color: #C71147 */
    
    static let shadesWhite20          = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2) /* Hex Color: #FFFFFF Opacity 20% */
    static let shadesWhite40          = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4) /* Hex Color: #FFFFFF Opacity 40% */
    static let shadesGrey             = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) /* Hex Color: #FAFAFA */
}

