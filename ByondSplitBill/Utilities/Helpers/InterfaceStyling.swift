//
//  InterfaceStyling.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func activateConstraints(
        top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,
        centerX: (anchor: NSLayoutXAxisAnchor, levitation: CGFloat)? = nil,
        centerY: (anchor: NSLayoutYAxisAnchor, levitation: CGFloat)? = nil,
        insets: UIEdgeInsets = .zero, width: CGFloat = .zero, height: CGFloat = .zero,
        customAnchors: [NSLayoutConstraint]? = []
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: insets.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: insets.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -insets.right).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.levitation).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY.anchor, constant: -centerY.levitation).isActive = true
        }
        
        if !width.isZero {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if !height.isZero {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let customAnchors = customAnchors {
            NSLayoutConstraint.activate(customAnchors)
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            
            if corners.contains(.topLeft) {
                cornerMask.insert(.layerMinXMinYCorner)
            }
            
            if corners.contains(.topRight) {
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            
            if corners.contains(.bottomLeft) {
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            
            if corners.contains(.bottomRight) {
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
        } else {
            let path = UIBezierPath(
                roundedRect: self.bounds, byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            
            self.layer.mask = mask
        }
    }
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 8
        layer.shadowColor = UIColor.black
            .withAlphaComponent(0.25).cgColor
    }
    
    func addShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black
            .withAlphaComponent(0.25).cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 8
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
    
    func removeShadow() {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 0
        layer.masksToBounds = true
    }
}

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
}

extension UIButton {
    
    func title(
        _ title: String, color: UIColor = .white,
        font: UIFont = .apply(fontName: .dmSansBold, size: .body)
    ) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        titleLabel?.font = font
    }
    
    func icon(source icon: UIImage) {
        setImage(icon, for: .normal)
    }
    
    func disable() {
        if let backgroundColor, backgroundColor != .clear {
            self.backgroundColor = .primaryGrey2
        }
        
        setTitleColor(.primaryGrey, for: .normal)
        isUserInteractionEnabled = false
    }
    
    func enable(bgColor: UIColor? = nil, titleColor: UIColor? = nil) {
        if let bgColor {
            backgroundColor = bgColor
        } else if let backgroundColor, backgroundColor != .clear {
            self.backgroundColor = .primaryGreen
        }
        
        setTitleColor(titleColor ?? .white, for: .normal)
        isUserInteractionEnabled = true
    }
}

extension NSMutableAttributedString {
    
    func attributesWithSpecific(
        range: NSRange, attributes: [NSAttributedString.Key: Any]
    ) {
        addAttributes(attributes, range: range)
    }
    
    func estimatedFrame(
        width: CGFloat = .apply(currentDevice: .screenWidth),
        height: CGFloat = .apply(currentDevice: .screenHeight)
    ) -> CGRect {
        return boundingRect(
            with: .init(width: width, height: height),
            options: .usesLineFragmentOrigin, context: nil
        )
    }
}

