//
//  InputPINViewController.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class InputPINViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var keyIcon: UIImageView!
    @IBOutlet var pinImages: [UIImageView]!
    @IBOutlet weak var pinStack: UIStackView!
    @IBOutlet weak var numberPad1: UIView!
    @IBOutlet weak var textPad1: UILabel!
    @IBOutlet weak var numberPad2: UIView!
    @IBOutlet weak var textPad2: UILabel!
    @IBOutlet weak var numberPad3: UIView!
    @IBOutlet weak var textPad3: UILabel!
    @IBOutlet weak var numberPad4: UIView!
    @IBOutlet weak var textPad4: UILabel!
    @IBOutlet weak var numberPad5: UIView!
    @IBOutlet weak var textPad5: UILabel!
    @IBOutlet weak var numberPad6: UIView!
    @IBOutlet weak var textPad6: UILabel!
    @IBOutlet weak var numberPad7: UIView!
    @IBOutlet weak var textPad7: UILabel!
    @IBOutlet weak var numberPad8: UIView!
    @IBOutlet weak var textPad8: UILabel!
    @IBOutlet weak var numberPad9: UIView!
    @IBOutlet weak var textPad9: UILabel!
    @IBOutlet weak var numberPad0: UIView!
    @IBOutlet weak var textPad0: UILabel!
    @IBOutlet weak var erasePad: UIView!
    @IBOutlet weak var backButton: UIView!
    @IBOutlet weak var forgetPINButton: UIButton!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var errorView: UILabel!
    @IBOutlet weak var topForgetPin: NSLayoutConstraint!
    @IBOutlet weak var viewWrongPass: UIView!
    @IBOutlet weak var keyboardStackView: UIStackView!
    
    private let presenter: InputPINPresenter
    var countClick = 0
    var maxLength = 6
    var inputtedPIN = ""
    
    
    init(presenter: InputPINPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSizeScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetPINView()
    }
}

// MARK: Functions
extension InputPINViewController {
    
    func generalSetup() {
        setupAction()
        setupView()
//        setupConditionalView(condition: condition)
        presenterListener()
    }
    
    func setupView() {
        setStyleOtpPad(numberPad1)
        setStyleOtpPad(numberPad2)
        setStyleOtpPad(numberPad3)
        setStyleOtpPad(numberPad4)
        setStyleOtpPad(numberPad5)
        setStyleOtpPad(numberPad6)
        setStyleOtpPad(numberPad7)
        setStyleOtpPad(numberPad8)
        setStyleOtpPad(numberPad9)
        setStyleOtpPad(numberPad0)
        setStyleOtpPad(erasePad)
        
        subtitleLabel.textColor = .fontColorBSIBlack80
        
        viewWrongPass.isHidden = true
    }
    
    func setStyleOtpPad(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if UIScreen.main.nativeBounds.height < 1334 {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 54),
                view.heightAnchor.constraint(equalToConstant: 54)
            ])
            
            view.layer.cornerRadius = 27
        } else {
            view.layer.cornerRadius = view.bounds.height / 2
        }
    }
    
    func setupConditionalView() {
        
    }
    
    func presenterListener() {
        
    }
    
    func setupAction() {
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(clickBack)
        ))
        
        numberPad1.isUserInteractionEnabled = true
        numberPad1.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "1", label: textPad1
        ))
        
        numberPad2.isUserInteractionEnabled = true
        numberPad2.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "2", label: textPad2
        ))
        
        numberPad3.isUserInteractionEnabled = true
        numberPad3.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "3", label: textPad3
        ))
        
        numberPad4.isUserInteractionEnabled = true
        numberPad4.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "4", label: textPad4
        ))
        
        numberPad5.isUserInteractionEnabled = true
        numberPad5.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "5", label: textPad5
        ))
        
        numberPad6.isUserInteractionEnabled = true
        numberPad6.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "6", label: textPad6
        ))
        
        numberPad7.isUserInteractionEnabled = true
        numberPad7.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "7", label: textPad7
        ))
        
        numberPad8.isUserInteractionEnabled = true
        numberPad8.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "8", label: textPad8
        ))
        
        numberPad9.isUserInteractionEnabled = true
        numberPad9.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "9", label: textPad9
        ))
        
        numberPad0.isUserInteractionEnabled = true
        numberPad0.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "0", label: textPad0
        ))
        
        erasePad.isUserInteractionEnabled = true
        erasePad.addGestureRecognizer(NumpadRecognizer(
            target: self, action: #selector(didTapNumpad(_:)),
            value: "", label: nil
        ))
    }
    
    func setupSizeScreen() {
        
    }
    
    func resetPINView() {
        
    }
    
    func updatePINImage(count: Int) {
        for i in 1...count {
            pinImages[i-1].image = UIImage(named: "icon-pin-blue")
        }
    }
    
    func validatePIN(data: String) {
        if data.count == maxLength {
           routeAfterValidate()
        } else {
            return
        }
    }
    
    func routeAfterValidate() {
        showLoadingAisyah()
        presenter.navigatetoTransactionStatusPage()
    }
    
    @objc func clickBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapNumpad(_ sender: NumpadRecognizer) {
        sender.label?.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            sender.label?.alpha = 1
        }
        
        if !sender.value.isEmpty {
            if countClick < maxLength {
                let currentPIN = inputtedPIN
                inputtedPIN = currentPIN + sender.value
                countClick = inputtedPIN.count
                updatePINImage(count: countClick)
                validatePIN(data: inputtedPIN)
            }  else {
                resetPINView()
                let currentPIN = self.inputtedPIN
                inputtedPIN = currentPIN + sender.value
                countClick = inputtedPIN.count
                updatePINImage(count: countClick)
                validatePIN(data: inputtedPIN)
            }
        } else {
            let currentPIN = inputtedPIN
            let deletedPin = currentPIN.dropLast()
            inputtedPIN = String(deletedPin)
            countClick = inputtedPIN.count
            updatePinImageOnDelete(count: countClick)
            validatePIN(data: inputtedPIN)
        }
    }
    
    func updatePinImageOnDelete(count: Int) {
        pinImages[count].image = UIImage(named: InputPinIcon.ICONPINGREY.value())
        if !errorView.isHidden {
            for i in 1...count {
                if pinImages[i-1].image == UIImage(named: InputPinIcon.ICONPINRED.value()) {
                    pinImages[i-1].image = UIImage(named: "icon-pin-blue")
                }
            }
            errorView.isHidden = true
            viewWrongPass.isHidden = true
        }
    }
}
