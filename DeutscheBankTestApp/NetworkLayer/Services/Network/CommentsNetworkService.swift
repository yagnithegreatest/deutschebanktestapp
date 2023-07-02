//
//  CommentsNetworkService.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

protocol CommentsNetworkServiceProtocol {
    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void)
}

final class CommentsNetworkService: CommentsNetworkServiceProtocol {
    
    // MARK: - Private properties
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - API
    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let request = CommentsRequest(postId: postId)
        networkService.request(request, completion: completion)
    }
}
