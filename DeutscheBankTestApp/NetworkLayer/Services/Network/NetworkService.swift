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

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Private properties
    private let networkSession: NetworkSessionProtocol
    private let reachabilityManager: ReachabilityManagerProtocol
    
    private var isReachable: Bool {
        return self.reachabilityManager.isReachable
    }
    
    // MARK: - Init
    init(networkSession: NetworkSessionProtocol = ServiceLocator.shared.getService(), reachabilityManager: ReachabilityManagerProtocol = ServiceLocator.shared.getService()) {
        self.networkSession = networkSession
        self.reachabilityManager = reachabilityManager
    }
    
    // MARK: - API
    func request<T: Codable>(
        _ request: Request,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard self.isReachable else {
            completion(.failure(NetworkError.notReachable))
            return
        }
        
        let url = "\(Constants.NetworkConstants.baseURL)/\(request.path)"
        
        self.networkSession.request(
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
