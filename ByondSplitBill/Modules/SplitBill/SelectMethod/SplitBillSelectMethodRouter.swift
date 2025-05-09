//
//  SplitBillSelectMethodRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct SplitBillSelectMethodRouter {
    
    static func showView() -> SplitBillSelectMethodVC {
        let router = SplitBillSelectMethodRouter()
        let interactor = SplitBillInteractor()
        let presenter = SplitBillSelectMethodPresenter(
            router: router, interactor: interactor
        )
        let view = SplitBillSelectMethodVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navigateToNextPage(from navigation: UINavigationController?, selectedMethod: Int) {
        switch selectedMethod {
        case 2:
            let view = SplitBillCreateNewRouter.showView()
            navigation?.pushViewController(view, animated: true)
        default: break
        }
    }
}
