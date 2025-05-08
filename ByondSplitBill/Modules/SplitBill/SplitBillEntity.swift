//
//  SplitBillEntity.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation

struct SplitBill {
    
    struct AccNumParam: Codable {
        var accNum: String
    }
    
    struct MyContactsResponse: Codable {
        var accountNumber: String?
        var name: String?
        
        enum CodingKeys: String, CodingKey {
            case accountNumber = "accounNumber"
            case name
        }
    }
}
