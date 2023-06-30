//
//  PostsNetworkService.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

protocol PostsNetworkServiceProtocol {
    func fetchPosts(userId: Int, completion: @escaping (Result<[PostAPIModel], Error>) -> Void)
}

class PostsNetworkService: PostsNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPosts(userId: Int, completion: @escaping (Result<[PostAPIModel], Error>) -> Void) {
        let request = PostsRequest(userId: userId)
        networkService.request(request, completion: completion)
    }
}
