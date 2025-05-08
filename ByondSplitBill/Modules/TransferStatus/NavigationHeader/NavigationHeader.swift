//
//  NavigationHeader.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 07/05/25.
//

import Foundation
import UIKit

class NavigationHeader: UIView {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var labelNavBar: UILabel!
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var leftMenu: UIView!
    @IBOutlet weak var rightMenu: UIView!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var secondRighMenu: UIView!
    @IBOutlet weak var secondRightIcon: UIImageView!
    @IBOutlet weak var secondRightBtn: UIButton!
    
    
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
        guard let view = loadViewFromNib(nibName: "NavigationHeader") else { return }
        
        view.frame = bounds
        
        addSubview(view)
        view.bringSubviewToFront(rightMenu)
    }
    
    func setupTitle(description: String) {
        labelNavBar.text = description
    }
    
    func setupRightMenu(isHidden: Bool, iconName: String = "icon-search") {
        rightMenu.isHidden = isHidden
        rightIcon.image = UIImage(named: iconName)
    }
    
    func setup2ndRightMenu(isHidden: Bool, iconName: String = "icon-Search") {
        secondRighMenu.isHidden = isHidden
        secondRightIcon.image = UIImage(named: iconName)
    }
    
    func setupLeftMenu(isHidden: Bool) {
        backBtn.isHidden = isHidden
        leftIcon.isHidden = isHidden
    }
    
    func setToWhiteIcon(isSetToWhite: Bool) {
        leftIcon.image = UIImage(named: "icon-back-white")
    }
}
