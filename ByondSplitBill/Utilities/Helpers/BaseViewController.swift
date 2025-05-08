//
//  BaseViewController.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    open var errorCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    @objc func blurBackgroundDismiss(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
}

extension BaseViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
