//
//  PostNetworkService+Requests.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Alamofire
import Foundation

struct PostsRequest: Request {
    
    let userId: Int
    
    var path: String {
        return "posts"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return ["userId": userId]
    }

    var encoding: URLEncoding {
        return .default
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}
