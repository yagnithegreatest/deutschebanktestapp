//
//  NetworkService.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(_ request: Request, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let networkSession: NetworkSessionProtocol
    
    init(networkSession: NetworkSessionProtocol = NetworkSession()) {
        self.networkSession = networkSession
    }
    
    func request<T: Codable>(
        _ request: Request,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        let url = "\(Constants.NetworkConstants.baseURL)/\(request.path)"
        
        networkSession.request(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: nil
        ) { data, error in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            }
        }
    }
}
