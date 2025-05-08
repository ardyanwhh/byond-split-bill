//
//  Tabbar.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class Tabbar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    var menu: [String?]? { didSet {
        collectionView.reloadData()
    }}
    var selectAction: ((IndexPath) -> Void)?
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    private let hLineSeparator = UIView()
    
    private func configure() {
        addSubviews(collectionView, hLineSeparator)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.id)
        collectionView.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            bottom: bottomAnchor, trailing: trailingAnchor,
            insets: .init(top: 0, left: 0, bottom: 1, right: 0)
        )
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = .zero
        
        hLineSeparator.backgroundColor = .textBlack40
        hLineSeparator.activateConstraints(
            leading: leadingAnchor, bottom: bottomAnchor,
            trailing: trailingAnchor, height: 1
        )
    }
    
    func selectItem(at indexPath: IndexPath, animated: Bool = true) {
        collectionView.selectItem(
            at: indexPath, animated: animated,
            scrollPosition: .centeredHorizontally
        )
    }
}

extension Tabbar:
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menu?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.id, for: indexPath) as! MenuCell
        
        if let menu, indexPath.item < menu.count {
            cell.configure(with: menu[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width / CGFloat(menu?.count ?? 0), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAction?(indexPath)
    }
}

private class MenuCell: UICollectionViewCell {
    
    static let id = String(describing: MenuCell.self)
    
    func configure(with title: String?) {
        titleLabel.text = title
    }
    
    override var isSelected: Bool { didSet {
        if isSelected {
            titleLabel.textColor = .textBlack100
            hLineIndicatorWidthAnchor?.constant = 32
        } else {
            titleLabel.textColor = .textBlack60
            hLineIndicatorWidthAnchor?.constant = 0
        }
        
        UIView.animate(withDuration: 0.25) {[weak self] in
            self?.contentView.layoutIfNeeded()
        }
    }}
    
    private let titleLabel = UILabel()
    private let hLineIndicator = UIView()
    private var hLineIndicatorWidthAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(titleLabel, hLineIndicator)
        
        titleLabel.textColor = .textBlack60
        titleLabel.font = .apply(fontName: .dmSansBold, size: .body2)
        titleLabel.textAlignment = .center
        titleLabel.activateConstraints(
            leading: leadingAnchor, trailing: trailingAnchor,
            centerY: (centerYAnchor, 4), insets: .init(
                top: 0, left: 8, bottom: 0, right: 8
            )
        )
        
        hLineIndicator.backgroundColor = .primaryYellow
        hLineIndicator.layer.cornerRadius = 2
        hLineIndicatorWidthAnchor = hLineIndicator.widthAnchor.constraint(equalToConstant: 0)
        hLineIndicator.activateConstraints(
            bottom: bottomAnchor, centerX: (centerXAnchor, 0),
            height: 4, customAnchors: [hLineIndicatorWidthAnchor!]
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
