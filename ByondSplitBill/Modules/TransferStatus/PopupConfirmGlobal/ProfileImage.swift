//
//  ProfileImage.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit

class ProfileImage: UIView {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    let charSet1 = ["A", "B", "C"]
    let charSet2 = ["D", "E", "F"]
    let charSet3 = ["G", "H", "I"]
    let charSet4 = ["J", "K", "L"]
    let charSet5 = ["M", "N", "O"]
    let charSet6 = ["P", "Q", "R"]
    let charSet7 = ["S", "T", "U", "V"]
    let charSet8 = ["W", "X", "Y", "Z"]
    
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
        guard let view = self.loadViewFromNib(nibName: "ProfileImage") else { return }
        imgBackground.layer.cornerRadius = imgBackground.frame.height/2
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setInitial(_ nameString: String) {
        let stringArr = nameString.components(separatedBy: " ")
        var firstName: String = ""
        var lastName: String = ""
        var stringName: String = ""
        if nameString != "-" {
            if stringArr.count > 1 {
                firstName = stringArr[0]
                lastName = stringArr[1]
                setBackground(firstLetter: "\(firstName.first ?? " ")")
                stringName = "\(firstName.first ?? " ")\(lastName.first ?? " ")"
            } else if nameString.isEmpty {
                stringName = ""
            } else {
                let onlyName = stringArr[0].uppercased()
                let onlyNameArr = onlyName.map({String($0)})
                let firstName = onlyNameArr[0]
                var lastName = ""
                if onlyNameArr.count > 1 {
                    lastName = onlyNameArr[1]
                }
                setBackground(firstLetter: firstName)
                stringName = "\(firstName)"
            }}
        
        lblName.text = stringName
    }
    
    func setBackground(firstLetter: String) {
        imgBackground.image = UIImage(named: "bg-circle-blue")
    }
}
