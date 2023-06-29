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

class CommentsNetworkService: CommentsNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let request = CommentsRequest(postId: postId)
        networkService.request(request, completion: completion)
    }
}
