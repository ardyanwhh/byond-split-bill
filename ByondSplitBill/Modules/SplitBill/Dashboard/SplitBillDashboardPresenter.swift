//
//  SplitBillDashboardPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import Combine

class SplitBillDashboardPresenter {
    
    private let router: SplitBillDashboardRouter
    private let interactor: SplitBillInteractor
    weak var view: SplitBillDashboardVC?
    
    init(router: SplitBillDashboardRouter, interactor: SplitBillInteractor) {
        self.router = router
        self.interactor = interactor
        
        $networkState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                self?.view?.assignState(with: state)
            }
            .store(in: &cancellableBag)
    }
    
    @Published var networkState: NetworkState = .idle
    var cancellableBag: Set<AnyCancellable> = []
    var consumables: [[Any?]?]?
    
    func fetch() {
        consumables = [[], []]
        networkState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            self?.networkState = .finished
        }
    }
    
    func navigateToSelectMethod() {
        router.navigateToSelectMethod(from: view?.navigationController)
    }
}

