//
//  TextField.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class TextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    var placeholderText: String? { didSet {
        if !isSaveExecuted {
            isSaveExecuted = true
            savedPlaceholder = placeholderText
        }
        
        attributedPlaceholder = .init(
            string: placeholderText ?? "",
            attributes: [.foregroundColor: UIColor.textBlack60]
        )
        
        captionLabel.text = savedPlaceholder
    }}
    private var savedPlaceholder: String?
    private var isSaveExecuted = false
    
    private let captionLabel = UILabel()
    
    private func configure() {
        delegate = self
        autocapitalizationType = .words
        textColor = .textBlack100
        tintColor = .primaryGreen
        font = .apply(fontName: .dmSansRegular, size: .body)
        layer.borderColor = UIColor.textBlack40.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
        
        addSubviews(captionLabel)
        
        captionLabel.alpha = 0
        captionLabel.font = .apply(fontName: .dmSansRegular, size: .caption)
        captionLabel.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            insets: .init(top: -24, left: 4, bottom: 0, right: 0),
            height: 16
        )
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.layer.borderColor = UIColor.primaryGreen.cgColor
            self?.placeholderText = nil
            
            self?.captionLabel.textColor = .primaryGreen
            self?.captionLabel.alpha = 1
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.layer.borderColor = UIColor.textBlack40.cgColor
            self?.placeholderText = self?.savedPlaceholder
            
            if textField.text?.isEmpty ?? false {
                self?.captionLabel.alpha = 0
            } else {
                self?.captionLabel.alpha = 1
                self?.captionLabel.textColor = .textBlack60
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
