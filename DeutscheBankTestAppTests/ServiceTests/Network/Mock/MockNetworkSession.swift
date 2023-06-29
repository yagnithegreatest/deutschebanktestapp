//
//  MockNetworkSession.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import Alamofire
import Foundation

class MockNetworkSession: NetworkSessionProtocol {
    
    var requestHandler: (
        (URLConvertible,
         HTTPMethod,
         Parameters?,
         ParameterEncoding,
         HTTPHeaders?) -> (Data?, Error?)
    )?
    
    func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Data?, Error?) -> Void
    ) {
        if let handler = requestHandler {
            let (data, error) = handler(url, method, parameters, encoding, headers)
            completion(data, error)
        }
    }
}
