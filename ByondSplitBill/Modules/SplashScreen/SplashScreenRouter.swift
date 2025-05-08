//
//  SplashScreenRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct SplashScreenRouter {
    
    static func showView() -> SplashScreenVC {
        let router = SplashScreenRouter()
        let presenter = SplashScreenPresenter(router: router)
        let view = SplashScreenVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navigateToMainModule(from navigation: UINavigationController?) {
        let view = SplitBillDashboardRouter.showView()
        navigation?.pushViewController(view, animated: true)
    }
}
