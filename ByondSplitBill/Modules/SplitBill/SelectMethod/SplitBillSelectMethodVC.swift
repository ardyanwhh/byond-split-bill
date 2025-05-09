//
//  SplitBillSelectMethodVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class SplitBillSelectMethodVC: BaseViewController {
    
    private let presenter: SplitBillSelectMethodPresenter
    
    init(presenter: SplitBillSelectMethodPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let navbar = Navbar()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    private let nextButton = UIButton()
    private let footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(navbar, titleLabel, subtitleLabel, collectionView, footerView)
        
        navbar.navigationForPopping = navigationController
        navbar.activateConstraints(motherView: view)
        
        titleLabel.text = .apply(localizedWithName: .splitBillSelectMethodTitle)
        titleLabel.textColor = .textBlack100
        titleLabel.font = .apply(fontName: .dmSansBold, size: .title3)
        titleLabel.activateConstraints(
            top: navbar.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, insets: .init(
                top: 0, left: 20, bottom: 0, right: 20
            )
        )
        
        subtitleLabel.text = .apply(localizedWithName: .splitBillSelectMethodSubtitle)
        subtitleLabel.textColor = .textBlack80
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = .apply(fontName: .dmSansRegular, size: .body)
        subtitleLabel.activateConstraints(
            top: titleLabel.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, insets: .init(
                top: 8, left: 20, bottom: 0, right: 20
            )
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MethodCell.self, forCellWithReuseIdentifier: MethodCell.id)
        collectionView.activateConstraints(
            top: subtitleLabel.bottomAnchor, leading: view.leadingAnchor,
            bottom: footerView.topAnchor, trailing: view.trailingAnchor,
            insets: .init(top: 20, left: 0, bottom: 0, right: 0)
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
        nextButton.addTarget(self, action: #selector(
            nextDidTap(_:)), for: .touchUpInside)
        nextButton.activateConstraints(
            top: footerView.topAnchor, leading: footerView.leadingAnchor,
            trailing: footerView.trailingAnchor, insets: .init(
                top: 20, left: 20, bottom: 0, right: 20
            ), height: 48
        )
    }
    
    @objc private func nextDidTap(_ sender: UIButton) {
        presenter.navigateToNextPage()
    }
}

extension SplitBillSelectMethodVC:
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MethodCell.id, for: indexPath) as! MethodCell
        cell.configure(with: presenter.methods[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 16 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - 40, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectedMethod = indexPath.item
        nextButton.enable()
    }
}

private class MethodCell: UICollectionViewCell {
    
    static let id = String(describing: MethodCell.self)
    
    func configure(with data: [String]) {
        titleLabel.text = data[0]
        subtitleLabel.text = data[1]
    }
    
    override var isSelected: Bool { didSet {
        if isSelected {
            layer.borderColor = UIColor.primaryGreen.cgColor
            checkmarkIV.image = .iconCheckmarkSelected
        } else {
            layer.borderColor = UIColor.textBlack40.cgColor
            checkmarkIV.image = .iconCheckmark
        }
    }}
    
    private let titleLabel = UILabel()
    private let checkmarkIV = UIImageView()
    private let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 16
        layer.borderColor = UIColor.textBlack40.cgColor
        layer.borderWidth = 1
        
        contentView.addSubviews(titleLabel, checkmarkIV, subtitleLabel)
        
        titleLabel.textColor = .textBlack100
        titleLabel.font = .apply(fontName: .dmSansBold, size: .body)
        titleLabel.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            trailing: trailingAnchor, insets: .init(
                top: 12, left: 16, bottom: 0, right: 16
            ), height: 24
        )
        
        checkmarkIV.image = .iconCheckmark
        checkmarkIV.activateConstraints(
            top: topAnchor, trailing: trailingAnchor, insets: .init(
                top: 12, left: 0, bottom: 0, right: 16
            ), width: 24, height: 24
        )
        
        subtitleLabel.numberOfLines = 3
        subtitleLabel.textColor = .textBlack80
        subtitleLabel.font = .apply(fontName: .dmSansRegular, size: .body2)
        subtitleLabel.activateConstraints(
            top: titleLabel.bottomAnchor, leading: leadingAnchor,
            trailing: trailingAnchor, insets: .init(
                top: 8, left: 16, bottom: 0, right: 16
            )
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
