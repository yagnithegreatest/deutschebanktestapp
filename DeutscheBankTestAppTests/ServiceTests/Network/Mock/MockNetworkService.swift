//
//  MockNetworkService.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import Foundation

// Can pass specified type to use the mock in different situations
class MockNetworkService<T: Codable>: NetworkServiceProtocol {
    
    var result: Result<T, Error>?
    
    func request<U: Codable>(_ request: Request, completion: @escaping (Result<U, Error>) -> Void) {
        
        guard let result = result as? Result<U, Error> else {
            fatalError("Didn't set result, or result is of the wrong type")
        }
        
        completion(result)
    }
}
