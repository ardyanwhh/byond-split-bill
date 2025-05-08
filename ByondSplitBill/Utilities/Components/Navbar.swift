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
    private var titleLabelLeadingAnchor: NSLayoutConstraint?
    private var titleLabelTrailingAnchor: NSLayoutConstraint?
    
    // right-menu
    private let rightMenuHSV = UIStackView()
    
    func assignRightMenu(buttons: [UIButton]) {
        guard buttons.count < 3 else { return }
        
        buttons.forEach { [weak self] button in
            self?.rightMenuHSV.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 56),
                button.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
        
        if buttons.count > 1 {
            titleLabelLeadingAnchor?.constant = 112
            titleLabelTrailingAnchor?.constant = -112
        }
    }
    
    // tint
    override var tintColor: UIColor! { didSet {
        titleLabel.textColor = tintColor
    }}
    
    private func configure() {
        addSubviews(navView)
        
        navView.activateConstraints(
            leading: leadingAnchor, bottom: bottomAnchor,
            trailing: trailingAnchor, height: 56
        )
        
        navView.addSubviews(popButton, titleLabel, rightMenuHSV)
        
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
        titleLabelLeadingAnchor = titleLabel.leadingAnchor
            .constraint(equalTo: navView.leadingAnchor, constant: 56)
        titleLabelTrailingAnchor = titleLabel.trailingAnchor
            .constraint(equalTo: navView.trailingAnchor, constant: -56)
        titleLabel.activateConstraints(
            centerY: (navView.centerYAnchor, 0), customAnchors: [
                titleLabelLeadingAnchor!, titleLabelTrailingAnchor!
            ]
        )
        
        rightMenuHSV.axis = .horizontal
        rightMenuHSV.activateConstraints(
            trailing: navView.trailingAnchor,
            centerY: (navView.centerYAnchor, 0),
            height: 48
        )
            
        tintColor = .black
        backgroundColor = .clear
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
