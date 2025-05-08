//
//  SplitBillDashboardVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import SkeletonView

class SplitBillDashboardVC: BaseViewController {
    
    private let presenter: SplitBillDashboardPresenter
    
    init(presenter: SplitBillDashboardPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let navbar = Navbar()
    private let tabbar = Tabbar()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    private let addNewButton = UIButton()
    private let footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(navbar, tabbar, collectionView, footerView)
        
        navbar.title = .apply(localizedWithName: .splitBillDashboardTitle)
        navbar.navigationForPopping = navigationController
        navbar.activateConstraints(motherView: view)
        
        tabbar.menu = [.apply(localizedWithName: .generalActive), .apply(localizedWithName: .generalHistory)]
        tabbar.selectItem(at: .init(item: 0, section: 0), animated: false)
        tabbar.selectAction = tabAction(at:)
        tabbar.activateConstraints(
            top: navbar.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, height: 56
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.id)
        collectionView.activateConstraints(
            top: tabbar.bottomAnchor, leading: view.leadingAnchor,
            bottom: footerView.topAnchor, trailing: view.trailingAnchor
        )
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = .zero
        
        footerView.activateConstraints(
            leading: view.leadingAnchor, bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            height: .apply(currentDevice: .bottomBarHeight) + 68
        )
        
        footerView.addSubview(addNewButton)
        
        addNewButton.title(.apply(localizedWithName: .splitBillDashboardButtonTitle))
        addNewButton.backgroundColor = .primaryGreen
        addNewButton.layer.cornerRadius = 24
        addNewButton.addTarget(self, action: #selector(
            addNewDidTap(_:)), for: .touchUpInside)
        addNewButton.activateConstraints(
            top: footerView.topAnchor, leading: footerView.leadingAnchor,
            trailing: footerView.trailingAnchor, insets: .init(
                top: 20, left: 20, bottom: 0, right: 20
            ), height: 48
        )
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        presenter.fetch()
    }
    
    func assignState(with state: NetworkState) {
        switch state {
        case .loading:
            collectionView.isSkeletonable = true
            collectionView.showAnimatedGradientSkeleton()
        case .finished:
            collectionView.hideSkeleton()
        default: break
        }
    }
    
    private func tabAction(at indexPath: IndexPath) {
        collectionView.scrollToItem(
            at: indexPath, at: .centeredHorizontally,
            animated: false
        )
    }
    
    @objc private func addNewDidTap(_ sender: UIButton) {
        presenter.navigateToSelectMethod()
    }
}

extension SplitBillDashboardVC:
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    SkeletonCollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.bounds.width
        let contentWidth = scrollView.contentSize.width
        let page = lround(offset / width)
        
        if offset > 0, offset < contentWidth - width {
            tabbar.selectItem(at: .init(item: page, section: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.id, for: indexPath) as! PageCell
        
        if let consumables = presenter.consumables, indexPath.item < consumables.count {
            cell.configure(at: indexPath, with: consumables[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { collectionView.bounds.size }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier { PageCell.id }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        (cell as? PageCell)?.configure(at: indexPath, with: nil)
    }
}

private class PageCell:
    UICollectionViewCell,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    SkeletonCollectionViewDataSource {
    
    static let id = String(describing: PageCell.self)
    
    func configure(at indexPath: IndexPath, with data: [Any?]?) {
        emptyView.alpha = 0
        
        if let data {
            
            if data.isEmpty {
                emptyView.alpha = 1
            }
        }
        
        switch indexPath.item {
        case 0:
            emptyView.title = .apply(localizedWithName: .splitBillDashboardActiveEmptyTitle)
            emptyView.descriptionText = .apply(localizedWithName: .splitBillDashboardActiveEmptyDescription)
        case 1:
            emptyView.title = .apply(localizedWithName: .splitBillDashboardHistoryEmptyTitle)
            emptyView.descriptionText = .apply(localizedWithName: .splitBillDashboardHistoryEmptyDescription)
        default: break
        }
    }
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    private let emptyView = EmptyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isSkeletonable = true
        
        contentView.addSubviews(emptyView, collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: ContentCell.id)
        collectionView.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            bottom: bottomAnchor, trailing: trailingAnchor
        )
        
        emptyView.alpha = 0
        emptyView.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            bottom: bottomAnchor, trailing: trailingAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.id, for: indexPath) as! ContentCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - 40, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 24, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 20 }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier { ContentCell.id }
}

private class ContentCell: UICollectionViewCell {
    
    static let id = String(describing: ContentCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
