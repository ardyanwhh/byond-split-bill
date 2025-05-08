//
//  Endpoints.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 08/05/25.
//

import Foundation
import Alamofire

struct Endpoints {
    
    static let baseURL: String = try! Environment.getValue(forKey: .baseURL)
    
    enum UserService: String {
        case getMyContact = "/get-my-contact"

        func url() -> URLConvertible { "\(baseURL)/user\(rawValue)" }
    }
}
