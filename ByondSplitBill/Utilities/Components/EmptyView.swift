//
//  EmptyView.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class EmptyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private let contentVSV = UIStackView()
    private let illustrationIV = UIImageView()
    
    // title
    
    var title: String? { didSet {
        titleLabel.text = title
    }}
    
    private let titleLabel = UILabel()
    
    // description-text
    
    var descriptionText: String? { didSet {
        descLabel.text = descriptionText
    }}
    
    private let descLabel = UILabel()
    
    private func configure() {
        addSubviews(contentVSV)
        
        contentVSV.axis = .vertical
        contentVSV.activateConstraints(
            leading: leadingAnchor, trailing: trailingAnchor,
            centerY: (centerYAnchor, 0), insets: .init(
                top: 0, left: 32, bottom: 0, right: 32
            )
        )
        
        contentVSV.addArrangedSubviews(illustrationIV, titleLabel, descLabel)
        
        illustrationIV.image = .imgBoxEmpty
        illustrationIV.contentMode = .scaleAspectFit
        illustrationIV.activateConstraints(height: 160)
        contentVSV.setCustomSpacing(24, after: illustrationIV)
        
        titleLabel.textColor = .textBlack100
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = .apply(fontName: .dmSansBold, size: .body)
        contentVSV.setCustomSpacing(8, after: titleLabel)
        
        descLabel.textColor = .textBlack80
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 3
        descLabel.font = .apply(fontName: .dmSansRegular, size: .body2)
    }
}
