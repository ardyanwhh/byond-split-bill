//
//  SplitBillDashboardVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class SplitBillDashboardVC: BaseViewController {
    
    private let presenter: SplitBillDashboardPresenter
    
    init(presenter: SplitBillDashboardPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
