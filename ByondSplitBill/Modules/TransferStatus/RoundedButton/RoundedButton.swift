//
//  RoundedButton.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 07/05/25.
//

import UIKit

class RoundedButton: UIView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblButton: UILabel!
    @IBOutlet weak var btnButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupView() {
        guard let view = self.loadViewFromNib(nibName: "RoundedButton") else { return }
        
        view.frame = self.bounds
        
        self.addSubview(view)
        
        mainView.layer.cornerRadius = 24.0
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = .newPrimaryBSIGreen
    }
}
