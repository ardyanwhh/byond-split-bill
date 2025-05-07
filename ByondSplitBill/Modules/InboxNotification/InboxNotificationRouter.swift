//
//  InboxNotificationRouter.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

struct InboxNotificationRouter {
    
    static func showView() -> InboxNotificationVC {
        let router = InboxNotificationRouter()
        let interactor = InboxNotificationInteractor()
        let presenter = InboxNotificationPresenter(
            router: router, interactor: interactor
        )
        let view = InboxNotificationVC(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
