//
//  InputPINPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import Combine

class InputPINPresenter {
    
    private let router: InputPINRouter
    private let interactor: InputPINInteractor
    weak var view: InputPINViewController?
    
    init(router: InputPINRouter, interactor: InputPINInteractor) {
        self.router = router
        self.interactor = interactor
    }
}
