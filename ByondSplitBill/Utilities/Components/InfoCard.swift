//
//  InfoCard.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class InfoCard: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    var descriptionText: String? { didSet {
        descriptionLabel.text = descriptionText
    }}
    
    private let iconView = UIImageView()
    private let descriptionLabel = UILabel()
    
    private func configure() {
        backgroundColor = .shadesGrey
        layer.cornerRadius = 16
        
        addSubviews(iconView, descriptionLabel)
        
        iconView.image = .iconInfoCircle
            .withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .secondaryBlue
        iconView.contentMode = .scaleAspectFit
        iconView.activateConstraints(
            leading: leadingAnchor, centerY: (centerYAnchor, 0), insets: .init(
                top: 0, left: 20, bottom: 0, right: 0
            ), width: 24, height: 24
        )
        
        descriptionLabel.textColor = .textBlack80
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = .apply(fontName: .dmSansRegular, size: .caption)
        descriptionLabel.activateConstraints(
            leading: iconView.trailingAnchor, trailing: trailingAnchor,
            centerY: (centerYAnchor, 0), insets: .init(
                top: 0, left: 16, bottom: 0, right: 20
            )
        )
    }
}
