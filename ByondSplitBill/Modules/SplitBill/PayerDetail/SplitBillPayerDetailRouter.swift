//
//  SplitBillPayerDetailRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct SplitBillPayerDetailRouter {
    
    static func showView() -> SplitBillPayerDetailVC {
        let router = SplitBillPayerDetailRouter()
        let interactor = SplitBillInteractor()
        let presenter = SplitBillPayerDetailPresenter(
            router: router, interactor: interactor
        )
        let view = SplitBillPayerDetailVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
