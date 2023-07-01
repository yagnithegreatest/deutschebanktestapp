//
//  MockPostsNetworkService.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

@testable import DeutscheBankTestApp
import Foundation

final class MockPostsNetworkService: PostsNetworkServiceProtocol {
    
    var postAPIModels: [PostAPIModel] = []
    
    func fetchPosts(userId: Int, completion: @escaping (Result<[PostAPIModel], Error>) -> Void) {
        completion(.success(self.postAPIModels))
    }
}
