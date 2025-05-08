//
//  TransferStatusEntity.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation

struct TransferStatus {
    
}

enum StatusTransaction: String {
    case success
    case failed
    case gagal
    case onprogress
    case suspect
}

struct PopupConfirmGlobalData {
    var title: String = ""
    var subtitle: String = ""
    var line: Bool = false
    var spaceView: Bool = false
    var spaceViewLocation: String = SpaceviewLocation.both.rawValue
    var boldedText: Bool = false
    var isShowAllButtonVisible: Bool = false
    var isInformationView: Bool = false
    var isAttributeTextOn: Bool = false
}

struct DetailTransferBuyer {
    
}

struct SummarayData {
    let title: String
    let value: String
    let subValue: String
    let background: String
}

struct SummarayDataSecond {
    let title: String
    let value: String
    let subValue: String
    let background: String
}

enum SpaceviewLocation: String {
    case top = "Top"
    case bottom = "Bottom"
    case both = "Both"
    
    func value() -> String {
        return self.rawValue
    }
}
