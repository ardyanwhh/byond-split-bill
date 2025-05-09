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
    private let addNewButton = UIButton()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: flowLayout
    )
    private let footerView = UIView()
    private let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(
            navbar, selectedContactView, searchBar,
            addNewButton, collectionView, footerView
        )
        
        navbar.title = "Pilih Anggota"
        navbar.navigationForPopping = navigationController
        navbar.assignRightMenu(buttons: [helpButton])
        navbar.activateConstraints(motherView: view)
        
        helpButton.icon(source: .iconQuestionMarkCircle)
        
        selectedContactView.contacts = presenter.selectedContacts
        selectedContactView.activateConstraints(
            top: navbar.bottomAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, height: 96
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
        
        addNewButton.title("Tambah Baru", font: .apply(fontName: .dmSansBold, size: .body2))
        addNewButton.backgroundColor = .primaryGreen
        addNewButton.layer.cornerRadius = 20
        addNewButton.activateConstraints(
            top: searchBar.bottomAnchor, leading: view.leadingAnchor,
            insets: .init(top: 20, left: 20, bottom: 0, right: 0),
            width: 120, height: 40
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.id)
        collectionView.activateConstraints(
            top: addNewButton.bottomAnchor, leading: view.leadingAnchor,
            bottom: footerView.topAnchor, trailing: view.trailingAnchor,
            insets: .init(top: 8, left: 0, bottom: 0, right: 0)
        )
        
        flowLayout.minimumLineSpacing = .zero
        flowLayout.sectionInset = .init(
            top: 4, left: 20, bottom: 0, right: 20
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
    
    @objc private func nextDidTap(_ sender: UIButton) {
        if let targetVC = navigationController?.viewControllers.first(where: { $0 is SplitBillCreateNewVC }) {
            navigationController?.popToViewController(targetVC, animated: true)
            (targetVC as? SplitBillCreateNewVC)?.selectContactCallback(contacts: presenter.selectedContacts)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ContactCell
        
        if presenter.contactSelectIndices.contains(indexPath) {
            presenter.contactSelectIndices.remove(indexPath)
            cell.changeSelected(false)
            
            if let response = presenter.response, indexPath.item < response.count {
                let selectedData = response[indexPath.item]
                
                if let match = presenter.selectedContacts.firstIndex(where: {
                    $0 == Contact(name: selectedData?.name, accountNumber: selectedData?.accountNumber)
                }) {
                    presenter.selectedContacts.remove(at: match)
                }
            }
        } else {
            presenter.contactSelectIndices.insert(indexPath)
            cell.changeSelected(true)
            
            if let response = presenter.response, indexPath.item < response.count {
                let selectedData = response[indexPath.item]
                presenter.selectedContacts.append(.init(
                    name: selectedData?.name, accountNumber: selectedData?.accountNumber
                ))
            }
        }
        
        selectedContactView.contacts = presenter.selectedContacts
        
        if presenter.contactSelectIndices.isEmpty {
            nextButton.disable()
        } else {
            nextButton.enable()
        }
        
        UIView.animate(withDuration: 0.25) {
            collectionView.performBatchUpdates(nil, completion: nil)
        }
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
    
    var contacts: [Contact?]? { didSet {
        collectionView.reloadData()
    }}
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contacts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedContactCell.id, for: indexPath) as! SelectedContactCell
        
        if let contacts, indexPath.item < contacts.count {
            cell.configure(at: indexPath, with: contacts[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { .init(width: 56, height: 96) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { .init(top: 0, left: 20, bottom: 0, right: 20) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 12 }
}

private class SelectedContactCell: UICollectionViewCell {
    
    static let id = String(describing: SelectedContactCell.self)
    
    func configure(at indexPath: IndexPath, with data: Contact?) {
        if let data {
            avatarIV.setInitial(with: data.name ?? "")
            
            if indexPath.item == 0 {
                captionLabel.text = "Kamu"
            } else {
                captionLabel.text = data.name
            }
        }
    }
    
    private let contentVSV = UIStackView()
    private let avatarIV = AvatarIV()
    private let captionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(avatarIV, captionLabel)
        
        avatarIV.layer.cornerRadius = 28
        avatarIV.activateConstraints(width: 56, height: 56)
        avatarIV.activateConstraints(
            top: topAnchor, leading: leadingAnchor,
            trailing: trailingAnchor, insets: .init(
                top: 8, left: 0, bottom: 0, right: 0
            ), height: 56
        )
        
        captionLabel.textColor = .textBlack100
        captionLabel.textAlignment = .center
        captionLabel.font = .apply(fontName: .dmSansRegular, size: .caption)
        captionLabel.activateConstraints(
            top: avatarIV.bottomAnchor, leading: leadingAnchor,
            trailing: trailingAnchor, insets: .init(
                top: 8, left: 0, bottom: 0, right: 0
            )
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
