//
//  SplitBillPayerDetailPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import Combine

class SplitBillPayerDetailPresenter {
    
    private let router: SplitBillPayerDetailRouter
    private let interactor: SplitBillInteractor
    weak var view: SplitBillPayerDetailVC?
    
    init(router: SplitBillPayerDetailRouter, interactor: SplitBillInteractor) {
        self.router = router
        self.interactor = interactor
    }
}
