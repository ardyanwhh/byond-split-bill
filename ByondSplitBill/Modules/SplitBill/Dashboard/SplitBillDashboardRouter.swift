//
//  SplitBillDashboardRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct SplitBillDashboardRouter {
    
    static func showView() -> SplitBillDashboardVC {
        let router = SplitBillDashboardRouter()
        let interactor = SplitBillInteractor()
        let presenter = SplitBillDashboardPresenter(
            router: router, interactor: interactor
        )
        let view = SplitBillDashboardVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navigateToSelectMethod(from navigation: UINavigationController?) {
        let view = SplitBillSelectMethodRouter.showView()
        navigation?.pushViewController(view, animated: true)
    }
}
