//
//  SearchBar.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class SearchBar: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private let magnifierIV = UIImageView()
    
    private func configure() {
        font = .apply(fontName: .dmSansRegular, size: .body)
        textColor = .textBlack100
        autocapitalizationType = .words
        backgroundColor = .shadesGrey
        tintColor = .primaryGreen
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubviews(magnifierIV)
        
        magnifierIV.image = .iconMagnifier
        magnifierIV.activateConstraints(
            leading: leadingAnchor, centerY: (centerYAnchor, 0),
            insets: .init(top: 0, left: 16, bottom: 0, right: 0),
            width: 20, height: 20
        )
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 12)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
