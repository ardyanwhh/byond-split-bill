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
}
