//
//  SplashScreenVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class SplashScreenVC: BaseViewController {
    
    private let presenter: SplashScreenPresenter
    
    init(presenter: SplashScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let byondLogoIV = UIImageView()
    private let footerHSV = UIStackView()
    private let footerLabel = UILabel()
    private let footerLPSIV = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.primaryGreen500.cgColor,
            UIColor.primaryGreen500.cgColor,
            UIColor.primaryYellow.cgColor
        ]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = .apply(currentDevice: .screenBounds)
        
        view.addSubviews(byondLogoIV, footerHSV)
        
        byondLogoIV.image = .imgByondLogoBig
        byondLogoIV.contentMode = .scaleAspectFit
        byondLogoIV.activateConstraints(
            top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor,
            trailing: view.trailingAnchor, insets: .init(
                top: 56, left: 32, bottom: 0, right: 32
            ), height: (.apply(currentDevice: .screenWidth) - 64) * 1.07
        )
        
        footerHSV.axis = .horizontal
        footerHSV.spacing = 8
        footerHSV.activateConstraints(
            leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor, insets: .init(
                top: 0, left: 32, bottom: 20, right: 32
            ), height: 42
        )
        
        footerHSV.addArrangedSubviews(footerLabel, footerLPSIV)
        
        footerLabel.text = .apply(localizedWithName: .splashFooter)
        footerLabel.textColor = .white
        footerLabel.numberOfLines = 3
        footerLabel.font = .apply(fontName: .dmSansRegular, size: .caption2)
        
        footerLPSIV.image = .iconLPSLogo
        footerLPSIV.contentMode = .scaleAspectFit
        footerLPSIV.activateConstraints(width: 48.8)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        presenter.fetch()
    }
    
    func assignState(with state: NetworkState) {
        guard case .finished = state else { return }
        presenter.navigateToMainModule()
    }
}
