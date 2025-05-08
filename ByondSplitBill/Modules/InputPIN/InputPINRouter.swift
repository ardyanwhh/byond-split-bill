//
//  InputPINRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct InputPINRouter {
    
    static func showView() -> InputPINViewController {
        let router = InputPINRouter()
        let interactor = InputPINInteractor()
        let presenter = InputPINPresenter(
            router: router, interactor: interactor
        )
        let view = InputPINViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navigatetoTransactionStatusPage(from navigation: UINavigationController?) {
        let view = TransferStatusRouter.showView()
        navigation?.pushViewController(view, animated: true)
    }
}
