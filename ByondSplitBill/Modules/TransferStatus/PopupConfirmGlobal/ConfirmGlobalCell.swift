//
//  ConfirmGlobalCell.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import UIKit

protocol ConfirmGlobalCellDelegate: AnyObject {
    func didShowAll()
}

class ConfirmGlobalCell: UITableViewCell {

    @IBOutlet weak var titleValueContainer: UIView!
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var bottomSeparator: UIView!
    @IBOutlet weak var showAllContainer: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationLbl: UILabel!
    @IBOutlet weak var valueContainer: UIStackView!
    @IBOutlet weak var showAllLabel: UILabel!
    @IBOutlet weak var showAllIcon: UIImageView!
    @IBOutlet weak var showAllButton: UIButton!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    
    static let identifier = String(describing: ConfirmGlobalCell.self)
    weak var delegate: ConfirmGlobalCellDelegate?
    var isExpanded = false
    var numberOfLineSubtitle = 0
    var maxNumberOfLineSubtitle = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topSeparator.isHidden = true
        bottomSeparator.isHidden = true
        showAllContainer.isHidden = true
        setupView()
        setupAction()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setupView() {
        informationView.setCorner(radius: 16.0)
    }
    
    func setupAction() {
        showAllButton.addTarget(self, action: #selector(showAllButtonTapped), for: .touchUpInside)

    }
    
    @objc private func showAllButtonTapped() {
        isExpanded.toggle()
        numberOfLineSubtitle = isExpanded ? 0 : 3
        value.numberOfLines = numberOfLineSubtitle
        showAllLabel.text = isExpanded ? "Sembunyikan" : "Lihat Semua"
        delegate?.didShowAll()
    }
}

extension UIView {
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

