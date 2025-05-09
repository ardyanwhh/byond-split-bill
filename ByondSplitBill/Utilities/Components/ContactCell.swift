//
//  ContactCell.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit
import SkeletonView

struct Contact: Equatable {
    var name: String?
    var accountNumber: String?
}

class ContactCell: UICollectionViewCell {
    
    static let id = String(describing: ContactCell.self)
    
    func configure(with data: Contact?) {
        if let data {
            [avatarIV, accountVSV, checkmarkIV].forEach {
                $0.alpha = 1
            }
            
            avatarIV.setInitial(with: data.name ?? "")
            titleLabel.text = data.name
            subtitleLabel.text = "BSI - \(data.accountNumber ?? "")"
        } else {
            [avatarIV, accountVSV, checkmarkIV].forEach {
                $0.alpha = 0
            }
        }
    }
    
    private let skeletonLabel = UILabel()
    private let avatarIV = AvatarIV()
    private let accountVSV = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let checkmarkIV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isSkeletonable = true
        
        contentView.addSubviews(skeletonLabel, avatarIV, accountVSV, checkmarkIV)
        
        skeletonLabel.isSkeletonable = true
        skeletonLabel.skeletonTextNumberOfLines = 2
        skeletonLabel.skeletonTextLineHeight = .fixed(18)
        skeletonLabel.linesCornerRadius = 4
        skeletonLabel.activateConstraints(
            leading: leadingAnchor, trailing: trailingAnchor,
            centerY: (centerYAnchor, 0)
        )
        
        avatarIV.activateConstraints(
            leading: leadingAnchor, centerY: (centerYAnchor, 0),
            width: 40, height: 40
        )
        
        accountVSV.axis = .vertical
        accountVSV.spacing = 4
        accountVSV.activateConstraints(
            leading: avatarIV.trailingAnchor,
            trailing: checkmarkIV.leadingAnchor,
            centerY: (centerYAnchor, 0), insets: .init(
                top: 0, left: 12, bottom: 0, right: 12
            )
        )
        
        accountVSV.addArrangedSubviews(titleLabel, subtitleLabel)
        
        titleLabel.textColor = .textBlack100
        titleLabel.font = .apply(fontName: .dmSansRegular, size: .body)
        
        subtitleLabel.textColor = .textBlack80
        subtitleLabel.font = .apply(fontName: .dmSansRegular, size: .body2)
        
        checkmarkIV.image = .iconCheckmark
        checkmarkIV.activateConstraints(
            trailing: trailingAnchor, centerY: (centerYAnchor, 0),
            width: 24, height: 24
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func changeSelected(_ isSelected: Bool) {
        if isSelected {
            checkmarkIV.image = .iconCheckmarkSelected
        } else {
            checkmarkIV.image = .iconCheckmark
        }
    }
}
