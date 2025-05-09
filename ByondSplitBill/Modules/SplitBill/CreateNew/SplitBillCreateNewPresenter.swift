//
//  SplitBillCreateNewPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit

class SplitBillCreateNewPresenter {
    
    private let router: SplitBillCreateNewRouter
    private let interactor: SplitBillInteractor
    weak var view: SplitBillCreateNewVC?
    
    init(router: SplitBillCreateNewRouter, interactor: SplitBillInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func navigateToSelectContact() {
        router.navigateToSelectContact(from: view?.navigationController)
    }
}
