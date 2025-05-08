//
//  NetworkCall.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import Foundation
import Combine
import Alamofire

class NetworkCall {
    
    static let shared = NetworkCall()
    
    func fetch<T: Codable>(
        _ endpoint: URLConvertible, method: HTTPMethod = .post, parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil
    ) -> Future<BaseResponse<T>, NetworkError<Any>> {
        return Future { promise in
            let networkReachability = NetworkReachabilityManager()
            
            if !(networkReachability?.isReachable ?? false) {
                NotificationCenter.default.post(name: .networkTimeout, object: nil)
                return
            }

            AF.request(
                endpoint, method: method, parameters: parameters, encoding: encoding,
                headers: headers, requestModifier: { $0.timeoutInterval = TimeInterval(60) }
            ).response {
                guard let response = $0.response,
                      let data = $0.data else { return }
                
                let responseHeaders = response.allHeaderFields
                
                let statusCode = $0.response?.statusCode ?? -1
                let decodedJSON = try? JSONDecoder().decode(BaseResponse<T>.self, from: $0.data!)
                
                if let serializeJSON = try? JSONSerialization.jsonObject(with: data) {
                    print(serializeJSON)
                }
                
                if statusCode >= 200 && statusCode < 300, let decodedJSON {
                    promise(.success(decodedJSON))
                } else if let decodedJSON {
                    promise(.failure(.errorWithResponse(decodedJSON)))
                } else {
                    promise(.failure(.unknown))
                }
            }
        }
    }
}

enum NetworkState {
    case idle
    case loading
    case finished
}

enum NetworkError<T: Any>: Error {
    case errorWithResponse(T?)
    case unknown
}

struct BaseResponse<T: Codable>: Codable {
    var data: T?
}

extension Notification.Name {
    
    static let networkTimeout = Notification.Name("network.timeout")
}

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        
        return dictionary
    }
}
