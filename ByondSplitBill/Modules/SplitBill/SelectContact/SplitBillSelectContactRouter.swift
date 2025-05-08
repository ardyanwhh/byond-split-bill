//
//  SplitBillSelectContactRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

struct SplitBillSelectContactRouter {
    
    static func showView() -> SplitBillSelectContactVC {
        let router = SplitBillSelectContactRouter()
        let interactor = SplitBillInteractor()
        let presenter = SplitBillSelectContactPresenter(
            router: router, interactor: interactor
        )
        let view = SplitBillSelectContactVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
