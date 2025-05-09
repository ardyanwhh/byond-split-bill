//
//  MoneyTextField.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class MoneyTextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private let fixedPrefix = "Rp "
    
    var placeholderText: String? { didSet {
        captionLabel.text = placeholderText
    }}
    
    private let captionLabel = UILabel()
    
    private func configure() {
        delegate = self
        text = fixedPrefix
        keyboardType = .numberPad
        textColor = .textBlack100
        tintColor = .primaryGreen
        font = .apply(fontName: .dmSansBold, size: .title)
        layer.borderColor = UIColor.textBlack40.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
        
        addSubviews(captionLabel)
        
        captionLabel.textColor = .textBlack60
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
            self?.captionLabel.textColor = .primaryGreen
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.layer.borderColor = UIColor.textBlack40.cgColor
            self?.captionLabel.textColor = .textBlack60
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location < fixedPrefix.count {
            return false
        }
        
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        let numericText = updatedText
            .replacingOccurrences(of: fixedPrefix, with: "")
            .replacingOccurrences(of: ".", with: "")
        
        let number = Int(numericText) ?? 0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "id_ID")
        
        if let formatted = formatter.string(from: NSNumber(value: number)) {
            textField.text = fixedPrefix + formatted
        } else {
            textField.text = fixedPrefix
        }
        
        return false
    }
    
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        return endOfDocument
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
}
