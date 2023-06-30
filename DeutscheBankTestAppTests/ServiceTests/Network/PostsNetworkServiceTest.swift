//
//  PostsNetworkServiceTest.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import XCTest

final class PostsNetworkServiceTest: XCTestCase {
    
    func testFetchPosts() {

        let expectedPosts = [PostAPIModel(userId: 1, id: 1, title: "Test", body: "Test")]
        
        let mockNetworkService = MockNetworkService<[PostAPIModel]>()
        mockNetworkService.result = .success(expectedPosts)
        
        let service = PostsNetworkService(networkService: mockNetworkService)
        
        var postArray: [PostAPIModel]?
        
        service.fetchPosts(userId: 1) { result in
            
            switch result {
            case .success(let posts):
                postArray = posts
            case .failure:
                postArray = nil
            }
        }
        
        XCTAssertEqual(postArray, expectedPosts)
    }
}
