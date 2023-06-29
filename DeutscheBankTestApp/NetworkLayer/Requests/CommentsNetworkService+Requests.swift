//
//  CommentsNetworkService+Requests.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Alamofire
import Foundation

struct CommentsRequest: Request {
    
    let postId: Int
    
    var path: String {
        return "posts/\(postId)/comments"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var encoding: URLEncoding {
        return .default
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}
