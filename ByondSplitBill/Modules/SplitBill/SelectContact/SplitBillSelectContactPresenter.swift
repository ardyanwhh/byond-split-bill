//
//  SplitBillSelectContactPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import UIKit
import Combine

class SplitBillSelectContactPresenter {
    
    private let router: SplitBillSelectContactRouter
    private let interactor: SplitBillInteractor
    weak var view: SplitBillSelectContactVC?
    
    init(router: SplitBillSelectContactRouter, interactor: SplitBillInteractor) {
        self.router = router
        self.interactor = interactor
        
        $networkState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                self?.view?.assignState(with: state)
            }
            .store(in: &cancellableBag)
    }
    
    @Published var networkState = NetworkState.idle
    var cancellableBag = Set<AnyCancellable>()
    var response: [SplitBill.MyContactsResponse?]?
    
    func fetch() {
        response = nil
        networkState = .loading
        
        let accNum = GlobalVariables.shared.accountNumber ?? ""
        
        interactor.fetchMyContact(parameters: .init(accNum: accNum))
            .sink {[weak self] result in
                switch result {
                case .finished:
                    self?.networkState = .finished
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] response in
                self?.response = response.data
            }
            .store(in: &cancellableBag)
    }
}
