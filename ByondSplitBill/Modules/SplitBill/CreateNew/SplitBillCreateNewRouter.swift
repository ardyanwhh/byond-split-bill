//
//  SplitBillCreateNewRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

struct SplitBillCreateNewRouter {
    
    static func showView() -> SplitBillCreateNewVC  {
        let router = SplitBillCreateNewRouter()
        let interactor = SplitBillInteractor()
        let presenter = SplitBillCreateNewPresenter(
            router: router, interactor: interactor
        )
        let view = SplitBillCreateNewVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navigateToSelectContact(from navigation: UINavigationController?) {
        let view = SplitBillSelectContactRouter.showView()
        navigation?.pushViewController(view, animated: true)
    }
}
