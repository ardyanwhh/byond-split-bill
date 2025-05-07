//
//  InboxNotificationPresenter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit
import Combine

class InboxNotificationPresenter {
    
    private let router: InboxNotificationRouter
    private let interactor: InboxNotificationInteractor
    weak var view: InboxNotificationVC?
    
    init(router: InboxNotificationRouter, interactor: InboxNotificationInteractor) {
        self.router = router
        self.interactor = interactor
    }
}
