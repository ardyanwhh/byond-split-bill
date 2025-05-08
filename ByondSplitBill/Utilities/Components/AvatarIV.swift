//
//  AvatarIV.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class AvatarIV: UIImageView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private let initialLabel = UILabel()
    
    private func configure() {
        layer.cornerRadius = 20
        clipsToBounds = true
        
        addSubviews(initialLabel)
        
        initialLabel.textColor = .white
        initialLabel.activateConstraints(
            centerX: (centerXAnchor, 0), centerY: (centerYAnchor, 0)
        )
    }
    
    func setInitial(with name: String, font: UIFont = .apply(fontName: .dmSansBold, size: .body)) {
        var result = ""
        
        name.split(separator: " ").forEach {
            result += ($0.first?.uppercased() ?? "")
        }
        
        initialLabel.text = result
        initialLabel.font = font
        
        let bgColors: [UIColor] = [
            .primaryGreen, .primaryYellow, .secondaryBlue,
                .secondaryPink, .secondaryPurple
        ]
        
        backgroundColor = bgColors[Int.random(in: 0..<bgColors.count)]
    }
}
