//
//  SplitBillPayerDetailVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class SplitBillPayerDetailVC: BaseViewController {
    
    private let presenter: SplitBillPayerDetailPresenter
    
    init(presenter: SplitBillPayerDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
