//
//  Navbar.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class Navbar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private let navView = UIView()
    
    // pop-navigation
    
    var navigationForPopping: UINavigationController? { didSet {
        popButton.alpha = navigationForPopping != nil ? 1 : 0
    }}
    
    var customPopBehaivour: (() -> Void)? { didSet {
        popButton.alpha = customPopBehaivour != nil ? 1 : 0
    }}
    
    private let popButton = UIButton()
    
    // title
    
    var title: String? { didSet {
        titleLabel.text = title
    }}
    
    private let titleLabel = UILabel()
    
    private func configure() {
        addSubviews(navView)
        
        navView.activateConstraints(
            leading: leadingAnchor, bottom: bottomAnchor,
            trailing: trailingAnchor, height: 56
        )
        
        navView.addSubviews(popButton, titleLabel)
        
        popButton.alpha = 0
        popButton.icon(source: .iconArrowLeft)
        popButton.addTarget(self, action: #selector(
            popDidTap(_:)), for: .touchUpInside)
        popButton.activateConstraints(
            leading: navView.leadingAnchor,
            centerY: (navView.centerYAnchor, 0),
            width: 56, height: 48
        )
        
        titleLabel.textColor = .textBlack100
        titleLabel.font = .apply(fontName: .dmSansBold, size: .body)
        titleLabel.textAlignment = .center
        titleLabel.activateConstraints(
            leading: navView.leadingAnchor, trailing: navView.trailingAnchor,
            centerY: (navView.centerYAnchor, 0), insets: .init(
                top: 0, left: 56, bottom: 0, right: 56
            )
        )
    }
    
    @objc private func popDidTap(_ sender: UIButton) {
        if let customPopBehaivour {
            customPopBehaivour()
            return
        }
        
        navigationForPopping?.popViewController(animated: true)
    }
    
    func activateConstraints(motherView view: UIView) {
        super.activateConstraints(
            top: view.topAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            height: .apply(currentDevice: .statusBarHeight) + 56
        )
    }
}
