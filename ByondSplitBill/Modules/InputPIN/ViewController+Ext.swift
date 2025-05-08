//
//  Untitled.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import UIKit

private var aView: UIView?
private var lodingAisyahView: ModalCustomLoading?

extension UIViewController {
    
    func showLoading() {
        aView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let blurEffectView = CustomVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 0.1)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.backgroundColor = .black.withAlphaComponent(0.5)
        blurEffectView.frame = aView!.bounds
        aView?.addSubview(blurEffectView)
        
        PopUpLoading(on: aView ?? UIView()).show()
        
        self.view.window?.addSubview(aView!)
        self.view.window?.insertSubview(aView!, aboveSubview: UIApplication.shared.statusBarUIView!)
    }
    
    func dismissLoading() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func showLoadingAisyah(titleText: String = "Mohon tunggu sebentar ya..", subtitle: String = "", backgroundColor: UIColor = .black.withAlphaComponent(0.5), fontColor: UIColor = .white) {
        lodingAisyahView = ModalCustomLoading()
        lodingAisyahView?.setTitleLoading(titleText: titleText, subtitle: subtitle)
        lodingAisyahView?.setBackgroundColor(backgroundColor: backgroundColor, fontColor: fontColor)
        lodingAisyahView?.frame = UIScreen.main.bounds
        
        self.view.addSubview(lodingAisyahView!)
        self.view.bringSubviewToFront(lodingAisyahView!)
    }
    
    func dismissLoadingAisyah() {
        lodingAisyahView?.removeFromSuperview()
        lodingAisyahView = nil
    }
    
}
