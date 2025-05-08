//
//  View+Ext.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadowView(_ width: CGFloat = 3.0, height: CGFloat = 4.0, opacidade: Float = 0.25, maskToBounds: Bool = false, radius: CGFloat = 6) {
        self.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacidade
        self.layer.masksToBounds = maskToBounds
    }
    
    enum ViewSide: String {
        case left = "Left",
             right = "Right",
             top = "Top",
             bottom = "Bottom",
             topSoft = "TopSoft",
             bottomSoft = "BottomSoft"
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CAShapeLayer.init()
        border.strokeColor = color
        border.lineDashPattern = [6, 4]
        border.lineWidth = 2
        let path = CGMutablePath()
        switch side {
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        case .top:
            path.addLines(between: [CGPoint(x: 0, y: 0),
                                    CGPoint(x: frame.width, y: 0)])
            border.path = path
        case .bottom:
            path.addLines(between: [CGPoint(x: 0, y: frame.height),
                                    CGPoint(x: frame.width, y: frame.height)])
            border.path = path
        case .topSoft:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottomSoft:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        }

        border.borderWidth = thickness
        
        layer.addSublayer(border)
    }
    
    func addRoundedBorder(_ cornerRadius: CGFloat, _ colorLine: CGColor, _ thickness: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = colorLine
        self.layer.borderWidth = thickness
    }
    
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return UIImage()}
        UIGraphicsEndImageContext()
        return image
    }
    
    func addTopRoundedCornerToView(targetView: UIView, desiredCurve: CGFloat) {
        let offset: CGFloat =  targetView.frame.width/desiredCurve
            let bounds: CGRect = targetView.bounds

            // Top side curve
            let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)

            let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)

            // Top side curve
            let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)

            let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
            rectPath.append(ovalPath)

            // Create the shape layer and set its path
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = rectPath.cgPath

            // Set the newly created shape layer as the mask for the view's layer
            targetView.layer.mask = maskLayer
    }
    
    func makeCornerRadius(_ radius: CGFloat, maskedCorner: CACornerMask?) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorner ?? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        clipsToBounds = true
    }
    
    func addDashedBorder() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.cornerRadius = 2
        shapeLayer.strokeColor = UIColor.primaryBSIGrey2.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [8, 6]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
