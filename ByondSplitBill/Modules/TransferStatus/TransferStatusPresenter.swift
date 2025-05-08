//
//  TransferStatusPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class TransferStatusPresenter {
    
    private let router: TransferStatusRouter
    private let interactor: TransferStatusInteractor
    weak var view: TransferStatusVC?
    
    init(router: TransferStatusRouter, interactor: TransferStatusInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func navigateToInputPIN() {
        router.navigateToInputPIN(from: view?.navigationController)
    }
}
