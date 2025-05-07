//
//  InboxNotificationVC.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

class InboxNotificationVC: BaseViewController {
    
    private let presenter: InboxNotificationPresenter
    
    init(presenter: InboxNotificationPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
