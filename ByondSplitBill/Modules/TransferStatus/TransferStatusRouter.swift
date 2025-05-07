//
//  TransferStatusRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct TransferStatusRouter {
    
    static func showView() -> TransferStatusVC {
        let router = TransferStatusRouter()
        let interactor = TransferStatusInteractor()
        let presenter = TransferStatusPresenter(
            router: router, interactor: interactor
        )
        let view = TransferStatusVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
