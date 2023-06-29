//
//  NetworkSession.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Alamofire
import Foundation

protocol NetworkSessionProtocol {
    
    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        completion: @escaping (Data?, Error?) -> Void
    )
}

class NetworkSession: NetworkSessionProtocol {
    
    func request(
         _ url: URLConvertible,
         method: HTTPMethod = .get,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = URLEncoding.default,
         headers: HTTPHeaders? = nil,
         completion: @escaping (Data?, Error?) -> Void
     ) {
         AF.request(
             url,
             method: method,
             parameters: parameters,
             encoding: encoding,
             headers: headers
         )
         .responseData { response in
             switch response.result {
             case .success(let data):
                 completion(data, nil)
             case .failure(let error):
                 completion(nil, error)
             }
         }
     }
}
