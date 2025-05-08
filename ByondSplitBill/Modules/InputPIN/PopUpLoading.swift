//
//  PopUpLoading.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import UIKit
import Lottie

class PopUpLoading {
    
    private let widthHeight: CGFloat = 150
    private var parentView: UIView
    private var animationView = AnimationView(name: "Loading White")
    private var backgroundCover: UIView
    private let common = Common.shared
    
    init(on view: UIView) {
        self.parentView = view
        animationView.alpha = 0.3
        animationView.isHidden = true
        self.backgroundCover = UIView()
        self.backgroundCover.backgroundColor = .clear
    }
    
    private func animateView() {
        animationView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIViewPropertyAnimator(
            duration: 0.3,
            dampingRatio: 0.6) { [weak self] () in
                guard let self = self else { return }
                self.animationView.isHidden = false
                self.animationView.alpha = 1
                self.animationView.transform = .identity
            } .startAnimation()
    }
    
    func show() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCover.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(backgroundCover)
        backgroundCover.addSubview(animationView)
        NSLayoutConstraint.activate([
            backgroundCover.topAnchor.constraint(equalTo: parentView.topAnchor),
            backgroundCover.leftAnchor.constraint(equalTo: parentView.leftAnchor),
            backgroundCover.rightAnchor.constraint(equalTo: parentView.rightAnchor),
            backgroundCover.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            animationView.widthAnchor.constraint(equalToConstant: widthHeight),
            animationView.heightAnchor.constraint(equalToConstant: widthHeight),
            animationView.centerXAnchor.constraint(equalTo: backgroundCover.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: backgroundCover.centerYAnchor)
        ])
        animateView()
    }
    
    func showInFull() {
        backgroundCover.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCover.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundCover.addSubview(animationView)
        parentView.addSubview(backgroundCover)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: widthHeight),
            animationView.heightAnchor.constraint(equalToConstant: widthHeight),
            backgroundCover.leftAnchor.constraint(equalTo: parentView.leftAnchor),
            backgroundCover.rightAnchor.constraint(equalTo: parentView.rightAnchor),
            animationView.centerXAnchor.constraint(equalTo: backgroundCover.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: backgroundCover.centerYAnchor, constant: 24)
        ])
        animateView()
    }
    
    func showLoadingAnimation() {
        backgroundCover.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        common.addViewToWindow { window in
            window.addSubview(backgroundCover)
            backgroundCover.addSubview(animationView)
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalToConstant: widthHeight),
                animationView.heightAnchor.constraint(equalToConstant: widthHeight),
                animationView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: window.centerYAnchor)
            ])
            animateView()
        }
    }
    
    func dismissAfter1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] () in
            guard let self = self else { return }
            self.animationView.removeFromSuperview()
            self.backgroundCover.removeFromSuperview()
            self.animationView.stop()
        }
    }
    
    func dismissImmediately() {
        DispatchQueue.main.async { [weak self] () in
            guard let self = self else { return }
            self.animationView.removeFromSuperview()
            self.backgroundCover.removeFromSuperview()
            self.animationView.stop()
        }
    }
}
