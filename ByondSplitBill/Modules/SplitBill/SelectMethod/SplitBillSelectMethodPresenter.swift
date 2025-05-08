//
//  SplitBillSelectMethodPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class SplitBillSelectMethodPresenter {
    
    private let router: SplitBillSelectMethodRouter
    private let interactor: SplitBillInteractor
    weak var view: SplitBillSelectMethodVC?
    
    init(router: SplitBillSelectMethodRouter, interactor: SplitBillInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    let methods: [[String]] = [
        [
            .apply(localizedWithName: .splitBillSelectMethodMenuTitle1),
            .apply(localizedWithName: .splitBillSelectMethodMenuSubtitle1),
        ],
        [
            .apply(localizedWithName: .splitBillSelectMethodMenuTitle2),
            .apply(localizedWithName: .splitBillSelectMethodMenuSubtitle2),
        ],
        [
            .apply(localizedWithName: .splitBillSelectMethodMenuTitle3),
            .apply(localizedWithName: .splitBillSelectMethodMenuSubtitle3),
        ],
    ]
}
