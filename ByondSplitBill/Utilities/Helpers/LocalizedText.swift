//
//  LocalizedText.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation

extension String {
    
    enum LocalizedText: String {
        
        case generalNext = "general.next"
        case generalActive = "general.active"
        case generalHistory = "general.history"
        
        case splashFooter = "splash.footer"
        
        case splitBillDashboardTitle = "split.bill.dashboard.title"
        case splitBillDashboardButtonTitle = "split.bill.dashboard.button.title"
        case splitBillDashboardActiveEmptyTitle = "split.bill.dashboard.active.empty.title"
        case splitBillDashboardActiveEmptyDescription = "split.bill.dashboard.active.empty.description"
        case splitBillDashboardHistoryEmptyTitle = "split.bill.dashboard.history.empty.title"
        case splitBillDashboardHistoryEmptyDescription = "split.bill.dashboard.history.empty.description"
        
        case splitBillSelectMethodTitle = "split.bill.select.method.title"
        case splitBillSelectMethodSubtitle = "split.bill.select.method.subtitle"
        case splitBillSelectMethodMenuTitle1 = "split.bill.select.method.menu.title1"
        case splitBillSelectMethodMenuTitle2 = "split.bill.select.method.menu.title2"
        case splitBillSelectMethodMenuTitle3 = "split.bill.select.method.menu.title3"
        case splitBillSelectMethodMenuSubtitle1 = "split.bill.select.method.menu.subtitle1"
        case splitBillSelectMethodMenuSubtitle2 = "split.bill.select.method.menu.subtitle2"
        case splitBillSelectMethodMenuSubtitle3 = "split.bill.select.method.menu.subtitle3"
    }
    
    static func apply(localizedWithName name: LocalizedText) -> String {
        NSLocalizedString(name.rawValue, comment: "")
    }
}

