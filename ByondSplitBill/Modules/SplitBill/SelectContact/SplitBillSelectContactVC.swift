//
//  SplitBillSelectContactVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit
import SkeletonView

class SplitBillSelectContactVC: BaseViewController {
    
    private let presenter: SplitBillSelectContactPresenter
    
    init(presenter: SplitBillSelectContactPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let navbar = Navbar()
    private let helpButton = UIButton()
    private let selectedContactView = SelectedContactView()
    private let searchBar = SearchBar()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(navbar, selectedContactView, searchBar, collectionView)
        
        navbar.title = "Pilih Anggota"
        navbar.navigationForPopping = navigationController
        navbar.assignRightMenu(buttons: [helpButton])
        navbar.activateConstraints(motherView: view)
        
//        helpButton.icon(source: .iconQuestionMarkCircle)
        
        selectedContactView.activateConstraints(
            top: navbar.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, height: 76
        )
        
        searchBar.attributedPlaceholder = .init(
            string: "Cari kontak", attributes: [
                .foregroundColor: UIColor.textBlack80
            ]
        )
        searchBar.activateConstraints(
            top: selectedContactView.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, insets: .init(
                top: 12, left: 20, bottom: 0, right: 20
            ), height: 48
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.id)
        collectionView.activateConstraints(
            top: searchBar.bottomAnchor, leading: view.leadingAnchor,
            bottom: view.bottomAnchor, trailing: view.trailingAnchor,
            insets: .init(top: 12, left: 0, bottom: 0, right: 0)
        )
        
        flowLayout.minimumLineSpacing = .zero
        flowLayout.sectionInset = .init(
            top: 4, left: 20, bottom: 0, right: 20
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.collectionView.hideSkeleton()
            }
        default: break
        }
    }
}

extension SplitBillSelectContactVC:
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    SkeletonCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.response?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.id, for: indexPath) as! ContactCell
        
        if let response = presenter.response, indexPath.item < response.count {
            let selectedData = response[indexPath.item]
            cell.configure(with: .init(name: selectedData?.name, accountNumber: selectedData?.accountNumber))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - 40, height: 76)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier { ContactCell.id }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        (cell as? ContactCell)?.configure(with: nil)
    }
}

private class SelectedContactView:
    UIView, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource {
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SelectedContactCell.self,
            forCellWithReuseIdentifier: SelectedContactCell.id)
        collectionView.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            bottom: bottomAnchor, trailing: trailingAnchor
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedContactCell.id, for: indexPath) as! SelectedContactCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { .init(width: 56, height: 96) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { .init(top: 0, left: 20, bottom: 0, right: 20) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 12 }
}

private class SelectedContactCell: UICollectionViewCell {
    
    static let id = String(describing: SelectedContactCell.self)
    
    private let contentVSV = UIStackView()
    private let avatarIV = AvatarIV()
    private let captionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(contentVSV)
        
        contentVSV.axis = .vertical
        contentVSV.spacing = 8
        contentVSV.activateConstraints(
            centerX: (centerXAnchor, 0), centerY: (centerYAnchor, 0),
            width: 56, height: 96
        )
        
        contentVSV.addArrangedSubviews(avatarIV, captionLabel)
        
        avatarIV.setInitial(with: "Ardyan Wahyu")
        avatarIV.activateConstraints(width: 56, height: 56)
        
        captionLabel.text = "Kamu"
        captionLabel.textColor = .textBlack100
        captionLabel.textAlignment = .center
        captionLabel.font = .apply(fontName: .dmSansRegular, size: .caption)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
