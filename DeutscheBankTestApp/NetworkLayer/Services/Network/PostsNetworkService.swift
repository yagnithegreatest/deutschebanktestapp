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

final class PostsNetworkService: PostsNetworkServiceProtocol {
    
    // MARK: - Private properties
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - API
    func fetchPosts(userId: Int, completion: @escaping (Result<[PostAPIModel], Error>) -> Void) {
        let request = PostsRequest(userId: userId)
        networkService.request(request, completion: completion)
    }
}
