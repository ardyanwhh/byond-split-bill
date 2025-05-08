//
//  ModalCustomLoading.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import UIKit

class ModalCustomLoading: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadingTitle: UILabel!
    @IBOutlet weak var loadingSubTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
        customBlurEffectView.frame = UIScreen.main.bounds
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.2)
        dimmedView.frame = UIScreen.main.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        guard let view = loadViewFromNib() else {
            return
        }
        let blurEffectView = CustomVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 0.1)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.startAnimating()
        view.frame = self.bounds
        self.addSubview(view)
        blurEffectView.frame = mainView!.bounds
        mainView.addSubview(blurEffectView)
        
    }
    
    func setTitleLoading(titleText: String, subtitle: String) {
        loadingTitle.text = titleText
        loadingSubTitle.text = subtitle
        PopUpLoading(on: loadingView ?? UIView()).showInFull()
        activityIndicator.isHidden = true
    }

    func setBackgroundColor(backgroundColor: UIColor, fontColor: UIColor) {
        mainView.backgroundColor = backgroundColor
        loadingTitle.textColor = fontColor
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "ModalCustomLoading", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}

