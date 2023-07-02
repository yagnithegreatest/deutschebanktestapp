//
//  NetworkError.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 02.07.2023.
//

import Foundation

enum NetworkError: Error {
    
    case notReachable
    case other(Error)
    
    var localizedDescription: String {
        switch self {
        case .notReachable:
            return LocalizableManager.noConnection
        case .other(let error):
            return error.localizedDescription
        }
    }
}
