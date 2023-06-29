//
//  ServiceLocator.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

class ServiceLocator {
    
    private var services: [String: Any] = [:]
    
    static let shared = ServiceLocator()
    
    func addService<T>(_ service: T) {
        
        let key = "\(T.self)"
        services[key] = service
    }
    
    func getService<T>() -> T {
        
        let key = "\(T.self)"
        
        guard let service = services[key] else {
            fatalError("Can't locate \(services[key] ?? "service")")
        }
        
        guard let castedService = service as? T else {
            fatalError("Service found for type \(T.self), but failed to cast")
        }
        
        return castedService
    }
}
