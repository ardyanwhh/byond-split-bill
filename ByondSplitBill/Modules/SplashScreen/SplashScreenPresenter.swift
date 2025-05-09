//
//  SplashScreenPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import Combine

class SplashScreenPresenter {
    
    private let router: SplashScreenRouter
    weak var view: SplashScreenVC?
    
    init(router: SplashScreenRouter) {
        self.router = router
        
        $networkState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                self?.view?.assignState(with: state)
            }
            .store(in: &cancellableBag)
        
        GlobalVariables.shared.accountNumber = "6604718851"
        GlobalVariables.shared.fullname = "Kevin"
    }
    
    @Published var networkState: NetworkState = .idle
    var cancellableBag: Set<AnyCancellable> = []
    var response: Any?
    
    func fetch() {
        response = nil
        networkState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            self?.networkState = .finished
        }
    }
    
    func navigateToMainModule() {
        router.navigateToMainModule(from: view?.navigationController)
    }
}
