//
//  SquareProfileImage.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit

class SquareProfileImage: UIView {
    
    @IBOutlet weak var imgBackground: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    
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
        guard let view = self.loadViewFromNib(nibName: "SquareProfileImage") else { return }
        
        imgBackground.layer.cornerRadius = 10.0
        imgBackground.layer.masksToBounds = true
        
        self.addSubview(view)
    }
    
    func setInitial(_ nameString: String) {
        let stringArr = nameString.components(separatedBy: " ")
        var firstName: String = ""
        var lastName: String = ""
        var stringName: String = ""
        if (stringArr.count > 1 && (stringArr[1] != "")) {
            firstName = stringArr[0]
            lastName = stringArr[1]
            
            stringName = "\(firstName.first!)\(lastName.first!)"
        } else {
            let onlyName = stringArr[0].uppercased()
            let onlyNameArr = onlyName.map({ String($0) })
            let firstName =  !onlyNameArr.isEmpty ? onlyNameArr[0] : ""
            let lastName = onlyNameArr.count > 1 ? onlyNameArr[1] : ""
            
            stringName = "\(firstName)\(lastName)"
        }
        
        lblName.text = stringName
    }
    
    func setBackground(_ accountType: String) {
        imgBackground.layer.backgroundColor = UIColor.primerBSIYellow700.cgColor
    }
}
