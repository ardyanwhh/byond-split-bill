//
//  Color+Ext.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 07/05/25.
//

import UIKit

extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }

    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6: chars.append(contentsOf: ["F", "F"])
        case 8: chars.append(contentsOf: ["F", "F"])
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }

    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6: chars.append(contentsOf: ["F", "F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
    
    class func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat? = nil) -> UIColor {
        if let alp = alpha {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alp)
        } else {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        }
    }
    
    class func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat? = nil) -> UIColor {
        if let alp = alpha {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alp)
        } else {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        }
    }
    
    var hexString: String? {
            if let components = self.cgColor.components {
                let red = components[0]
                let green = components[1]
                let blue = components.count > 2 ? components[2] : 0.0
                let alpha = components.count > 3 ? components[3] : 0.0
                return  String(format: "%02X%02X%02X%02X", (Int)(red * 255), (Int)(green * 255), (Int)(blue * 255), (Int)(alpha * 255))
            }
            return nil
        }
    
    static let primaryBSIGreen             = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.6980392157, alpha: 1) /* Hex Color: #00BFB2 */
    static let primaryBSIGreen2            = #colorLiteral(red: 0, green: 0.6784313725, blue: 0.6901960784, alpha: 1) /* Hex Color: #00ADB0 */
    static let primaryBSIGreen3            = #colorLiteral(red: 0, green: 0.7803921569, blue: 0.7450980392, alpha: 1) /* Hex Color: #00C7BE */
    static let primaryBSIGreen4            = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.5019607843, alpha: 1) /* Hex Color: #007C80 */
    static let primaryBSIYellow            = #colorLiteral(red: 0.9490196078, green: 0.7058823529, blue: 0.2549019608, alpha: 1) /* Hex Color: #F2B441 */
    static let primaryBSIYellow2           = #colorLiteral(red: 1, green: 0.6, blue: 0, alpha: 1) /* Hex Color: #FF9900 */
    static let primaryBSIGrey              = #colorLiteral(red: 0.5333333333, green: 0.5450980392, blue: 0.5529411765, alpha: 1) /* Hex Color: #888B8D */
    static let primaryBSIGrey2             = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1) /* Hex Color: #E0E0E0 */
    static let primaryBSIGrey3             = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) /* Hex Color: #F0F0F0 */
    static let primaryBSIGrey4             = #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1) /* Hex Color: #616161 */
    static let primaryBSIWhite             = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) /* Hex Color: #FFFFFF */
    static let navyBlueCardBackground     = #colorLiteral(red: 0, green: 0.2784313725, blue: 0.7333333333, alpha: 1) /* Hex Color: #0047BB */
    static let yellowCardBackground       = #colorLiteral(red: 0.9450980392, green: 0.7058823529, blue: 0.2039215686, alpha: 1) /* Hex Color: #F1B434 */
    static let turquoiseCardBackground    = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.6980392157, alpha: 1) /* Hex Color: #00BFB2 */
    static let primerBSIGreen900          = #colorLiteral(red: 0, green: 0.2901960784, blue: 0.2549019608, alpha: 1) /* Hex Color: #004A41 */
    static let primerBSIGreen700          = #colorLiteral(red: 0, green: 0.462745098, blue: 0.4274509804, alpha: 1) /* Hex Color: #00766D */
    static let primerBSIGreen500          = #colorLiteral(red: 0, green: 0.5098039216, blue: 0.4941176471, alpha: 1) /* Hex Color: #00827E */
    static let primerBSIGreen200          = #colorLiteral(red: 0.5490196078, green: 0.7803921569, blue: 0.7764705882, alpha: 1) /* Hex Color: #8CC7C6 */
    static let primerBSIGreen50           = #colorLiteral(red: 0.8862745098, green: 0.9411764706, blue: 0.9490196078, alpha: 1) /* Hex Color: #E2F0F2 */

    static let primerBSIYellow900         = #colorLiteral(red: 0.8941176471, green: 0.5411764706, blue: 0.2666666667, alpha: 1) /* Hex Color: #E48A44 */
    static let primerBSIYellow700         = #colorLiteral(red: 0.8941176471, green: 0.5411764706, blue: 0.2666666667, alpha: 1) /* Hex Color: #ED8B00 */
    static let primerBSIYellow500         = #colorLiteral(red: 0.9647058824, green: 0.9019607843, blue: 0.4039215686, alpha: 1) /* Hex Color: #F6E667 */
    static let primerBSIYellow200         = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.6784313725, alpha: 1) /* Hex Color: #FDF4AD */
    static let primerBSIYellow100         = #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9019607843, alpha: 1) /* Hex Color: #FFF5E6 */
    static let primerBSIYellow50          = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.9215686275, alpha: 1) /* Hex Color: #FFFDEB */
    
    static let secondaryBSIPurple         = #colorLiteral(red: 0.5568627451, green: 0.3843137255, blue: 0.7019607843, alpha: 1) /* Hex Color: #8E62B3 */
    static let secondaryBSIBlue           = #colorLiteral(red: 0.3137254902, green: 0.6196078431, blue: 0.8980392157, alpha: 1) /* Hex Color: #509EE5 */
    static let secondaryBSIRed            = #colorLiteral(red: 0.8980392157, green: 0.3450980392, blue: 0.3137254902, alpha: 1) /* Hex Color: #E55850 */
    static let secondaryBSIPink           = #colorLiteral(red: 0.937254902, green: 0.6941176471, blue: 0.6392156863, alpha: 1) /* Hex Color: #EFB1A3 */
    static let secondaryBSICream          = #colorLiteral(red: 0.9647058824, green: 0.9607843137, blue: 0.9411764706, alpha: 1) /* Hex Color: #F6F5F0 */
    
    static let newPrimaryBSIGreen         = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.6980392157, alpha: 1) /* Hex Color: #00BFB2 */
    static let newPrimaryBSIRed           = #colorLiteral(red: 0.8549019608, green: 0.1764705882, blue: 0.1882352941, alpha: 1) /* Hex Color: #DA2D30 */
    static let newSecondaryBSIRed         = #colorLiteral(red: 0.9411764706, green: 0, blue: 0, alpha: 1) /* Hex Color: #F00000 */
    static let failedRedBSI10              = #colorLiteral(red: 0.9176470588, green: 0.2549019608, blue: 0.2196078431, alpha: 0.1029158839) /* Hex Color: #02BE20 */
    
    static let newPrimerGreen             = #colorLiteral(red: 0.8941176471, green: 0.9647058824, blue: 0.9647058824, alpha: 1) /* Hex Color: #E4F6F6 */
    
    static let shadesBSI                  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2) /* Hex Color: #FFFFFF Opacity 20% */
    
    static let fontColorBSIBlack100     = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.96) /* Hex Color: #000000 Opacity 96% */
    static let fontColorBSIBlack80      = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.62) /* Hex Color: #000000 Opacity 62% */
    static let fontColorBSIBlack60      = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38) /* Hex Color: #000000 Opacity 38% */
    static let fontColorBSIBlack40      = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12) /* Hex Color: #000000 Opacity 12%  */
    static let fontColorBSIRed           = #colorLiteral(red: 0.8431372549, green: 0.2549019608, blue: 0.2666666667, alpha: 1) /* Hex Color: #D74144 */
    static let fontColorBSIGreen         = #colorLiteral(red: 0.4196078431, green: 0.7411764706, blue: 0.3294117647, alpha: 1) /* Hex Color: #6BBD54 */
    /// Add Color Border View Bottom Line OTP (Yudha Pratama Putra)
    static let fontColorBSIGreenOTP      = #colorLiteral(red: 0.3137254902, green: 0.7019607843, blue: 0.6823529412, alpha: 1) /* Hex Color: #50B3AE */
    
    static let backgroundBlackTransparent = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5255235927) /* Hex Color: #000000 Opacity 53% */
    static let whiteColorBackground       = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) /* Hex Color: #FAFAFA */
    static let snackbarBackgroundRed      = #colorLiteral(red: 0.7803921569, green: 0.06666666667, blue: 0.2784313725, alpha: 1) /* Hex Color: #C71147 */
    
    static let tintColorWhiteTransparent  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4) /* Hex Color: #FFFFFF Opacity 40% */
}

