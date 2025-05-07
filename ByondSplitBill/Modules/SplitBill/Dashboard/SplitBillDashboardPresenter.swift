//
//  SplitBillDashboardPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class SplitBillDashboardPresenter {
    
    private let router: SplitBillDashboardRouter
    private let interactor: SplitBillInteractor
    weak var view: SplitBillDashboardVC?
    
    init(router: SplitBillDashboardRouter, interactor: SplitBillInteractor) {
        self.router = router
        self.interactor = interactor
    }
}
