//
//  TransferStatusVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import AVFoundation
import Lottie

class TransferStatusVC: BaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var navHeader: NavigationHeader!
    @IBOutlet weak var navHeaderContainer: UIView!
    @IBOutlet weak var mainReceiptTableView: UITableView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var btnRounded: RoundedButton!
    @IBOutlet weak var btnRoundedSecond: RoundedButton!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var transactionStatusStackview: UIStackView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var detailTransaksi: UIView!
    @IBOutlet weak var detailTableStackView: UIStackView!
    @IBOutlet weak var viewDownloadBtn: UIView!
    @IBOutlet weak var viewShareBtn: UIView!
    @IBOutlet weak var viewSecondTable: UIView!
    @IBOutlet weak var secondTable: UITableView!
    @IBOutlet weak var arrowDetail: UIImageView!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var additionalTableContainer: UIView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var textStatus: UILabel!
    @IBOutlet weak var sendReport: UIView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var complaintButton: UIButton!
    @IBOutlet weak var shareDownloadView: UIView!
    @IBOutlet weak var secondButton: UIView!
    @IBOutlet weak var btnSecond: GeneralButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var topviewConstrain: NSLayoutConstraint!
    @IBOutlet weak var additionalViewConstrain: UIView!
    @IBOutlet weak var topTableView: UIView!
    @IBOutlet weak var separatorTableView: UIView!
    @IBOutlet weak var viewWordingEmas: UIView!
    @IBOutlet weak var labelWordingEmas: UILabel!
    @IBOutlet weak var containerWording: UIView!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var scrollViewStatus: UIScrollView!
    @IBOutlet weak var viewButtonSeperator: UIView!
    @IBOutlet weak var bottomConstraintTopTable: NSLayoutConstraint!
    @IBOutlet weak var stackViewStatus: UIStackView!
    @IBOutlet weak var qrSuspectAnimateView: UIView!
    @IBOutlet weak var bottomConstraintTransDetail: NSLayoutConstraint!
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    private let presenter: TransferStatusPresenter
    
    init(presenter: TransferStatusPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var popupConfirm = PopupConfirmGlobal()
    var status = StatusTransaction.success.rawValue
    var animationView: AnimationView?
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var firstTab = [SummarayData]()
    var secondTab = [SummarayDataSecond]()
    
    enum Status: String {
        case success
        case failed

        var value: String {
            return self.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = nil;
        navigationItem.hidesBackButton = true
        guard let type = StatusTransaction(rawValue: status) else { return }
        showAnimateTransaction(statusTransaction: type)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopAndRemoveAnimation(animationView: animationView ?? AnimationView())
        animationView = nil
    }
    
    deinit {
        print("DEINIT TRANSFER STATUS")
    }
}

extension TransferStatusVC {
    func setup() {
        setupView()
        configureTable()
        registerDataBinding()
        presenterListener()
        setupAction()
        mappingDataUISource()
    }
    
    func setupView() {
        descLabel.isHidden = false
        
        additionalTableContainer.isHidden = true
        mainReceiptTableView.showsVerticalScrollIndicator = false
        mainReceiptTableView.isScrollEnabled = false
        mainReceiptTableView.allowsSelection = false
        
        self.secondTable.showsVerticalScrollIndicator = false
        self.secondTable.isScrollEnabled = false
        secondTable.allowsSelection = false
        
        detailTransaksi.layer.cornerRadius = 20.0
        detailTransaksi.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        detailTableStackView.layer.shadowColor = UIColor.gray.cgColor
        detailTableStackView.layer.shadowOffset = CGSize(width: 0, height: 3)
        detailTableStackView.layer.shadowRadius = 7.0
        detailTableStackView.layer.shadowOpacity = 0.15
        
        viewSecondTable.layer.cornerRadius = 20.0
        viewSecondTable.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        tableContainer.layer.cornerRadius = 20.0
        tableContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        navHeader.setupTitle(description: "Detail Transaksi")
        navHeader.labelNavBar.textColor = .white
        navHeader.leftIcon.image = UIImage(named: "icon-back-white")
        navHeader.setupRightMenu(isHidden: true)
        viewButtonSeperator.isHidden = false
        scrollViewStatus.delegate = self
        dateLbl.textColor = UIColor.fontColorBSIBlack60
        
        btnRounded.lblButton.text = "Bayar Sekarang"
        btnRoundedSecond.lblButton.text = "Kembali"
        btnRoundedSecond.isHidden = true
        
        btnSecond.titleLabel?.font = .bsiBold(16)
        btnSecond.setStyleOutlinedButton(bgColor: .white, outlineColor: UIColor.primaryBSIGreen)
        btnSecond.setFontColor(fontColor: UIColor.primaryBSIGreen)
        btnSecond.makeCornerRadius(25, maskedCorner: nil)
        
        viewWordingEmas.isHidden = true
        
        containerWording.roundCorners(.allCorners, radius: 8.0)
        
        scrollViewStatus.contentInsetAdjustmentBehavior = .never
//        adjustViewForSmallDevice()
        setupAnimation()
        mainScrollView.contentInsetAdjustmentBehavior = .never
        mainScrollView.setContentOffset(.zero, animated: false)
    }
    
    func configureTable() {
        mainReceiptTableView.backgroundColor = .clear
        mainReceiptTableView.separatorStyle = .none
        mainReceiptTableView.estimatedRowHeight = 40.0
        mainReceiptTableView.rowHeight = UITableView.automaticDimension
        mainReceiptTableView.register(SummaryCellView.nib, forCellReuseIdentifier: SummaryCellView.identifier)
        mainReceiptTableView.dataSource = self
        mainReceiptTableView.delegate = self

        secondTable.backgroundColor = .clear
        secondTable.separatorStyle = .none
        secondTable.estimatedRowHeight = 60.0
        secondTable.rowHeight = UITableView.automaticDimension
        secondTable.register(SummaryCellView.nib, forCellReuseIdentifier: SummaryCellView.identifier)
        secondTable.dataSource = self
        secondTable.delegate = self
        
        // manual reload
        mainReceiptTableView.reloadData()
        secondTable.reloadData()
    }

    
    func registerDataBinding() {
        
    }
    
    func presenterListener() {
        
    }
    
    func setupAction() {
        setupActionDefault()
        setupActionRoundedButton()
    }
    
    func mappingDataUISource() {
        
    }
    
    func setupActionDefault() {
        navHeader.backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        
    }
    
    func setupActionRoundedButton() {
        btnRounded.btnButton.isUserInteractionEnabled = true
        btnRounded.btnButton.addTarget(self, action: #selector(clickContinue), for: .touchUpInside)
    }
    
    func showPopupConfirm(_ data: DetailTransferBuyer) {
       
        dismissLoading()
        popupConfirm.modalPresentationStyle = .custom
        popupConfirm.modalTransitionStyle = .coverVertical
        popupConfirm.transitioningDelegate = self
        present(popupConfirm, animated: true)
        
        defaultPopupConfirm(data)
        
        popupConfirm.setPopupTitle("Konfirmasi Transfer")
        popupConfirm.delegate = self
        popupConfirm.configureTable()
    }
    
    func defaultPopupConfirm(_ data: DetailTransferBuyer) {
    
        popupConfirm.setCardReciverCircle(title: "KEVIN RIVALDO JUSTICIO TULAK", subtitle: "BSI - 7274369967", accountType: "SA")
        popupConfirm.data = []
//        
//        if let method =  presenter?.dataTransferInfoList.first(where: { $0.transactionCategory == presenter?.transferObject?.transferType }) {
//            transferMethod = method.labelId
//        }
        
        popupConfirm.data.append(PopupConfirmGlobalData(title: "Nominal Transfer",
                                            subtitle: "Rp 20.000,00",
                                            line: false,
                                            spaceView: false))
        popupConfirm.data.append(PopupConfirmGlobalData(title: "Biaya Admin",
                                                             subtitle: "Rp 0",
                                                             line: false,
                                                             spaceView: false))
        popupConfirm.data.append(PopupConfirmGlobalData(title: "Total",
                                                             subtitle: "Rp 20.000,00",
                                                             line: true,
                                                             spaceView: false,
                                                             boldedText: true))
        popupConfirm.data.append(PopupConfirmGlobalData(title: "Catatan",
                                                             subtitle: "Pembayaran Split Bill",
                                                             line: false,
                                                             spaceView: false))
    }
    
    @objc private func clickContinue() {
        showPopupConfirm(DetailTransferBuyer())
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupAnimation() {
        status = StatusTransaction.onprogress.rawValue
        showAnimateTransaction(statusTransaction: .onprogress)
    }
    
    func stopAndRemoveAnimation(animationView: AnimationView) {
        animationView.stop()
        animationView.removeFromSuperview()
        animationView.animation = nil
        LRUAnimationCache.sharedCache.clearCache()
    }
    
    func showAnimateTransaction(statusTransaction: StatusTransaction){
        animationView = showAnimateSuccessTransaction(view: qrSuspectAnimateView, statusTransaction: statusTransaction)
        imgBackground.isHidden = false
    }
    
    func showAnimateSuccessTransaction(view: UIView, statusTransaction: StatusTransaction) -> AnimationView {
        var lottieName = ""
        switch statusTransaction {
        case .success:
            lottieName = "SuccessTransaction"
        case .failed:
            lottieName = "FailedTransaction"
        default:
            lottieName = "InprogressTransaction"
        }
        let animationView = AnimationView(name: lottieName)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        view.isHidden = false
        return animationView
    }
    
    func setupCellLabel(label: UILabel, attributeText: String){
        let color = getAttributeValue(attributeText: attributeText, searchText: "color")
        let weight = getAttributeValue(attributeText: attributeText, searchText: "weight")
        let size = Float(getAttributeValue(attributeText: attributeText, searchText: "size"))

        label.textColor = UIColor(hexaARGB: color)
        if weight == "bold" {
            label.font = .bsiBold(CGFloat(size ?? 16.0))
        } else {
            label.font = .bsiRegular(CGFloat(size ?? 14.0))
        }
//        label.font = weight == "bold" ? .bsiBold(CGFloat(size ?? 16.0)) : .bsiRegular(CGFloat(size ?? 14.0))
    }
    
    func getAttributeValue(attributeText: String, searchText: String) -> String {
        var text = ""
        if let match = attributeText.range(of: "(?<=\(searchText)=\")(\\S*)(?=\")", options: .regularExpression) {
            text = String(attributeText[match])
        }
        return text
    }
    
    func setValueLabel(label: UILabel, title: String) {
        // MARK: - change title label style based on updated Figma
        if title.contains("<font") {
            self.setupCellLabel(label: label, attributeText: title)
        } else {
            label.font = .bsiRegular(14)
            label.textColor = UIColor.fontColorBSIBlack80
        }
    }
    
    func getValueText(attributeText: String) -> (text: String, type: String?) {
        var text = ""
        var type = ""
        
        if let match = attributeText.range(of: "(?<=>)(.*)(?=</font>)", options: .regularExpression) {
            text = String(attributeText[match])
        } else {
            text = attributeText
        }
        
        do {
            let pattern = "type=\"(.*?)\""
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let nsString = attributeText as NSString
            let results = regex.matches(in: attributeText, options: [], range: NSRange(location: 0, length: nsString.length))

            if let match = results.first {
                type = nsString.substring(with: match.range(at: 1))
            }
        } catch {
            print("Error extracting type: \(error)")
        }

        return (text, type)
    }
    
    func validateShrink(label: UILabel, text: String, fontSize: CGFloat = 12) {
        let valueText = self.getValueText(attributeText: text)
        if valueText.type?.lowercased() == "shrink" {
            valueText.text.setAttributeAfterComma(to: label, smallFontSize: fontSize)
        } else {
            label.text = valueText.text
        }
    }
    
}

extension TransferStatusVC: GlobalConfirmDelegation {
    func didTap() {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            presenter.navigateToInputPIN()
        }
    }
}

extension TransferStatusVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainReceiptTableView {
            return firstTab.count
        } else if tableView == secondTable {
            return secondTab.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SummaryCellView.identifier, for: indexPath
        ) as? SummaryCellView else {
            return UITableViewCell()
        }

        if tableView == mainReceiptTableView {
            let item = firstTab[indexPath.row]
            setupCellLabel(label: cell.lblValue, attributeText: item.value)
            setupCellLabel(label: cell.lblSubvalue, attributeText: item.subValue)
            setValueLabel(label: cell.lblTitle, title: item.title)

            let valueTitle = getValueText(attributeText: item.title)
            cell.lblTitle.text = valueTitle.text
            cell.lblSubvalue.isHidden = item.subValue.isEmpty
            validateShrink(label: cell.lblValue, text: item.value)

            let subValue = getValueText(attributeText: item.subValue)
            cell.lblSubvalue.text = subValue.text
            cell.separator.isHidden = indexPath.row == (firstTab.count - 1)

            if item.value.contains("<b>") {
                let valueFormat = item.value.replacingOccurrences(of: "<b>", with: "")
                                             .replacingOccurrences(of: "</b>", with: "")
                cell.lblValue.text = valueFormat
            }

        } else if tableView == secondTable {
            let item = secondTab[indexPath.row]
            let valueTitle = getValueText(attributeText: item.title)
            cell.lblTitle.text = valueTitle.text

            setupCellLabel(label: cell.lblValue, attributeText: item.value)
            setupCellLabel(label: cell.lblSubvalue, attributeText: item.subValue)
            setValueLabel(label: cell.lblTitle, title: item.title)
            cell.lblSubvalue.isHidden = item.subValue.isEmpty

            let valueText = getValueText(attributeText: item.value)
            if valueText.text.isEmpty {
                cell.lblValue.text = "-"
                cell.lblValue.layer.opacity = 0.0
            } else {
                cell.lblValue.text = valueText.text
                cell.lblValue.layer.opacity = 1.0
                validateShrink(label: cell.lblValue, text: item.value)
            }

            let subValue = getValueText(attributeText: item.subValue)
            cell.lblSubvalue.text = subValue.text
            cell.separator.isHidden = indexPath.row == (secondTab.count - 1)
        }

        return cell
    }

    
}

extension String {
    /* Convert string from "Rp 0,00" to ,00 decrease font size */
    func setAttributeAfterComma(to label: UILabel,
                                defaultValue: String = "Rp 0,00",
                                smallFontSize: CGFloat = 14,
                                fontType: String = "",
                                additionalValue: String? = nil) {
        let balance = self.isEmpty ? defaultValue : self
        let decimalIndex = (balance.lastIndex(of: ",")?.utf16Offset(in: balance) ?? 0) + 1
        let balanceCount = balance.count
        let decimalPointLength = balanceCount - decimalIndex

        let attString = NSMutableAttributedString(string: balance)
        let fontType = UIFont(name: fontType.isEmpty ? label.font.fontName : fontType, size: smallFontSize)
        if decimalIndex < balanceCount {
            attString.addAttributes([NSAttributedString.Key.font: fontType ?? UIFont()], range: NSRange(location: decimalIndex, length: decimalPointLength))
        }
        
        if let additionalValue = additionalValue {
            let additionalValueIndex = decimalIndex + decimalPointLength
            let additionalValueLength = additionalValue.count
            attString.append(NSAttributedString(string: additionalValue))
            attString.addAttributes([NSAttributedString.Key.font: label.font ?? UIFont()], range: NSRange(location: additionalValueIndex, length: additionalValueLength))
        }
        
        label.attributedText = attString
        label.adjustsFontSizeToFitWidth = true
    }
}
