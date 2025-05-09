//
//  SplitBillCreateNewVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class SplitBillCreateNewVC: BaseViewController {
    
    private let presenter: SplitBillCreateNewPresenter
    
    init(presenter: SplitBillCreateNewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let navbar = Navbar()
    private let helpButton = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let infoCard = InfoCard()
    private let nameTextField = TextField()
    private let moneyTextField = MoneyTextField()
    private let selectContactButton = UIButton()
    private let nextButton = UIButton()
    private let footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(navbar, scrollView, footerView)
        
        navbar.navigationForPopping = navigationController
        navbar.assignRightMenu(buttons: [helpButton])
        navbar.activateConstraints(motherView: view)
        
        helpButton.icon(source: .iconQuestionMarkCircle)
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.activateConstraints(
            top: navbar.bottomAnchor, leading: view.leadingAnchor,
            bottom: footerView.topAnchor, trailing: view.trailingAnchor
        )
        
        scrollView.addSubviews(contentView)
        
        contentView.clipsToBounds = true
        contentView.activateConstraints(
            top: scrollView.topAnchor, leading: scrollView.leadingAnchor,
            bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,
            width: .apply(currentDevice: .screenWidth), height: 448
        )
        
        contentView.addSubviews(
            titleLabel, subtitleLabel, infoCard,
            nameTextField, moneyTextField,
            selectContactButton
        )
        
        titleLabel.text = "Buat Split Bill"
        titleLabel.textColor = .textBlack100
        titleLabel.font = .apply(fontName: .dmSansBold, size: .title3)
        titleLabel.activateConstraints(
            top: contentView.topAnchor, leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor, insets: .init(
                top: 0, left: 20, bottom: 0, right: 20
            ), height: 24
        )
        
        subtitleLabel.text = "Masukkan semua data yang sesuai dengan preferensi kamu"
        subtitleLabel.textColor = .textBlack80
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = .apply(fontName: .dmSansRegular, size: .body)
        subtitleLabel.activateConstraints(
            top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor, insets: .init(
                top: 8, left: 20, bottom: 0, right: 20
            ), height: 48
        )
        
        infoCard.descriptionText = "Patikan semua data terisi"
        infoCard.activateConstraints(
            top: subtitleLabel.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, insets: .init(
                top: 12, left: 20, bottom: 0, right: 20
            ), height: 56
        )
        
        nameTextField.placeholderText = "Nama Split Bill"
        nameTextField.activateConstraints(
            top: infoCard.bottomAnchor, leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor, insets: .init(
                top: 48, left: 20, bottom: 0, right: 20
            ), height: 48
        )
        
        moneyTextField.placeholderText = "Nominal Total"
        moneyTextField.activateConstraints(
            top: nameTextField.bottomAnchor, leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor, insets: .init(
                top: 60, left: 20, bottom: 0, right: 20
            ), height: 72
        )
        
        selectContactButton.title("Pilih Anggota", font: .apply(fontName: .dmSansBold, size: .body2))
        selectContactButton.backgroundColor = .primaryGreen
        selectContactButton.layer.cornerRadius = 20
        selectContactButton.addTarget(self, action: #selector(
            selectContactDidTap(_:)), for: .touchUpInside)
        selectContactButton.activateConstraints(
            top: moneyTextField.bottomAnchor, leading: contentView.leadingAnchor,
            insets: .init(top: 32, left: 20, bottom: 0, right: 0),
            width: 170, height: 40
        )
        
        footerView.activateConstraints(
            leading: view.leadingAnchor, bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            height: .apply(currentDevice: .bottomBarHeight) + 68
        )
        
        footerView.addSubview(nextButton)
        
        nextButton.title(.apply(localizedWithName: .generalNext))
        nextButton.backgroundColor = .primaryGreen
        nextButton.layer.cornerRadius = 24
        nextButton.disable()
        nextButton.activateConstraints(
            top: footerView.topAnchor, leading: footerView.leadingAnchor,
            trailing: footerView.trailingAnchor, insets: .init(
                top: 20, left: 20, bottom: 0, right: 20
            ), height: 48
        )
    }
    
    @objc private func selectContactDidTap(_ sender: UIButton) {
        presenter.navigateToSelectContact()
    }
    
    func selectContactCallback(contacts: [Contact]) {
        print(contacts)
    }
}

extension SplitBillCreateNewVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset > 50 {
            navbar.title = "Buat Split Bill"
        } else {
            navbar.title = nil
        }
    }
}
