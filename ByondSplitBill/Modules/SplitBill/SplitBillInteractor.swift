//
//  SplitBillInteractor.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation
import Combine
import Alamofire

struct SplitBillInteractor {
    
    func fetchMyContact(parameters: SplitBill.AccNumParam) -> Future<BaseResponse<[SplitBill.MyContactsResponse]>, NetworkError<Any>> {
        NetworkCall.shared.fetch(
            Endpoints.UserService.getMyContact.url(),
            parameters: try? parameters.asDictionary()
        )
    }
}
