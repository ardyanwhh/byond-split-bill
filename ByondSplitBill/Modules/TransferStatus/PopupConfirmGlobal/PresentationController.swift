//
//  PresentationController.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import UIKit

class PresentationController: UIPresentationController {
    
    var blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var mainViewHeight = 0
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.01),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
                            0.99))
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.backgroundColor = .black.withAlphaComponent(0.5)
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.backgroundColor = .black.withAlphaComponent(0.5)
            
        }, completion: { _ in
            /* do nothing */
        })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0
        }, completion: { _ in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 24)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.backgroundColor = .clear
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
