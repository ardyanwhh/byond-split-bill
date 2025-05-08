//
//  PopupConfirmGlobal.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import UIKit

protocol GlobalConfirmDelegation: AnyObject {
    func didTap()
}

class PopupConfirmGlobal: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstSeparator: UIView!
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameAcc: UILabel!
    @IBOutlet weak var accNumber: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var confirmButton: RoundedButton!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableContent: ContentSizedTableView!
    @IBOutlet weak var squareProfileImg: SquareProfileImage!
    @IBOutlet weak var cardreceiverConstraintRight: NSLayoutConstraint!
    @IBOutlet weak var stackAccDetail: UIStackView!
    @IBOutlet weak var constraintRightStackView: NSLayoutConstraint!
    @IBOutlet weak var circleProfileImage: ProfileImage!
    
    @IBOutlet weak var cardReceiverConstraintHeight: NSLayoutConstraint!
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var data = [PopupConfirmGlobalData]()
    weak var delegate: GlobalConfirmDelegation?
    var isExpanded = false
    var currentPopupHeight: CGFloat = 0.0
    var defaultMainPopupHeight = 0.0
    var defaultTableHeight: CGFloat = 0.0
    var isAdjustablePopup = false
    /// Allows value label to be expandable and title label to shrink
    var isValueExpandable = false
    var contentContainerType: UIStackView.Distribution = .equalSpacing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableHeight.constant = tableContent.contentSize.height
    }
    
    deinit {
        print("Do Nothing")
    }
}

extension PopupConfirmGlobal {
    func setupAction() {
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(blurBackgroundDismiss(_:))
        ))
        
        view.addGestureRecognizer(UIPanGestureRecognizer(
            target: self, action: #selector(modalPanAction(_:))
        ))
        
        closeBtn.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        confirmButton.btnButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)

    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func confirmButtonTapped() {
        delegate?.didTap()
    }

    
    func setupView() {
        if #available(iOS 11.0, *) {
            mainView.layer.cornerRadius = 24.0
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
            mainView.layer.cornerRadius = 24.0
        }
        
        slideIndicator.layer.cornerRadius = 4.0
        confirmButton.lblButton.text = "Konfirmasi"
        squareProfileImg.isHidden = true
        profileImage.isHidden = false
        circleProfileImage.isHidden = true
        mainView.layer.removeAllAnimations()
        tableContent.layer.removeAllAnimations()
    }
    
    func configureTable() {
        tableContent.backgroundColor = .none
        tableContent.separatorStyle = .none
        tableContent.showsHorizontalScrollIndicator = false
        tableContent.showsVerticalScrollIndicator = false
        tableContent.register(ConfirmGlobalCell.nib(), forCellReuseIdentifier: ConfirmGlobalCell.identifier)
        tableContent.rowHeight = UITableView.automaticDimension
        tableContent.dataSource = self
        tableContent.isUserInteractionEnabled = true
        tableContent.isScrollEnabled = true
        tableContent.bounces = false
        tableContent.delegate = self
        tableContent.reloadData()
    }
    
    func setPopupTitle(_ title: String) {
        mainTitle.text = title
    }
    
    func setCardReceiver(title: String, subtitle: String, profileImg: UIImage) {
        nameAcc.text = title
        accNumber.text = subtitle
        profileImage.image = profileImg
        squareProfileImg.isHidden = true
        profileImage.isHidden = false
    }
    
    func setCardRecieverURL(title: String, subtitle: String, profileImg: String) {
        nameAcc.text = title
        accNumber.text = subtitle
        profileImage.loadFrom(urlAddress: profileImg)
        squareProfileImg.isHidden = true
        profileImage.isHidden = false
    }
    
    func setCardReceiverWithSquareProfile(title: String, subtitle: String, accountType: String) {
        nameAcc.text = title
        accNumber.text = subtitle
        squareProfileImg.setInitial(title)
        squareProfileImg.setBackground(accountType)
        squareProfileImg.isHidden = false
        profileImage.isHidden = true
        cardreceiverConstraintRight.constant = 45
        constraintRightStackView.constant = 32
    }
    
    func setCardReciverCircle(title: String, subtitle: String, accountType: String) {
        nameAcc.text = title
        accNumber.text = subtitle
        circleProfileImage.setInitial(title)
        circleProfileImage.setBackground(firstLetter: title)
        circleProfileImage.isHidden = false
        squareProfileImg.isHidden = true
        profileImage.isHidden = true
    }
    
    @objc func modalPanAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {[weak self] in
                    guard let self else {return}
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

extension PopupConfirmGlobal: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmGlobalCell.identifier, for: indexPath) as? ConfirmGlobalCell ?? ConfirmGlobalCell()
        let item = data[indexPath.row]

        cell.valueContainer.distribution = contentContainerType
        cell.titleValue.text = item.title
        cell.separator.isHidden = !item.line
        if item.spaceView {
            switch item.spaceViewLocation {
            case SpaceviewLocation.top.rawValue:
                cell.topSeparator.isHidden = false
                cell.bottomSeparator.isHidden = true
            case SpaceviewLocation.bottom.rawValue:
                cell.topSeparator.isHidden = true
                cell.bottomSeparator.isHidden = false
            default:
                cell.topSeparator.isHidden = false
                cell.bottomSeparator.isHidden = false
            }
        } else {
            if item.line {
                cell.topSeparator.isHidden = false
                cell.bottomSeparator.isHidden = false
            } else {
                cell.topSeparator.isHidden = false
                cell.bottomSeparator.isHidden = true
            }
        }
        
        if isValueExpandable {
            cell.valueContainer.distribution = .fill
            cell.titleValueContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
            cell.titleValueContainer.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            cell.value.setContentHuggingPriority(.required, for: .horizontal)
            cell.value.setContentCompressionResistancePriority(.required, for: .horizontal)
            cell.value.numberOfLines = 1
            cell.titleValue.numberOfLines = 0
        }
        
        cell.selectionStyle = .none
        
        let subtitleListCount = item.subtitle.components(separatedBy: ",")
        
        if subtitleListCount.count > 3 && item.isShowAllButtonVisible {
            cell.numberOfLineSubtitle = 3
            cell.value.numberOfLines = 3
            cell.showAllContainer.isHidden = false
        } else {
            cell.numberOfLineSubtitle = 0
            cell.value.numberOfLines = 0
            cell.showAllContainer.isHidden = true
        }
        
        if item.isInformationView {
            cell.informationView.isHidden = false
            cell.valueContainer.isHidden = true
            cell.informationLbl.text = item.title
        } else {
            cell.informationView.isHidden = true
            cell.valueContainer.isHidden = false
        }
        
        cell.delegate = self
        
        if item.boldedText {
            cell.value.font = .bsiBold(18)
            cell.value.textColor = .fontColorBSIBlack100
        } else {
            cell.value.font = .bsiRegular(14)
            cell.value.textColor = .fontColorBSIBlack80
        }
        
        cell.showAllButton.isUserInteractionEnabled = true
        
        if item.title.lowercased() == "atas nama"{
            cell.btmConstraint.isActive = false
        }
        
        if item.isAttributeTextOn {
            cell.value.font = .bsiBold(21)
            cell.value.textColor = .fontColorBSIBlack100
            
            let balance = item.subtitle
            let decimalIndex = (balance.firstIndex(of: ",")?.utf16Offset(in: balance) ?? 0) + 1
            let balanceCount = balance.count
            let decimalPointLength = balanceCount - decimalIndex

            var attString: NSMutableAttributedString?
            attString = NSMutableAttributedString.init(string: String(format: "\(balance)"))
            attString?.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSRange(location: decimalIndex, length: decimalPointLength))
            cell.value.attributedText = attString
        } else {
            cell.value.text = item.subtitle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PopupConfirmGlobal: ConfirmGlobalCellDelegate {
    func didShowAll() {
        tableContent.beginUpdates()
        isExpanded = !isExpanded
        viewWillLayoutSubviews()
        tableContent.endUpdates()
    }
}

