//
//  PostsNetworkServiceTest.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import XCTest

final class PostsNetworkServiceTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService<[PostAPIModel]>!
    var service: PostsNetworkService!

    override func setUp() {
        super.setUp()
        self.mockNetworkService = MockNetworkService<[PostAPIModel]>()
        self.service = PostsNetworkService(networkService: self.mockNetworkService)
    }

    override func tearDown() {
        self.mockNetworkService = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchPosts() {
        let expectation = self.expectation(description: "Posts Network Service Test")
        
        let expectedPosts = [PostAPIModel(userId: 1, id: 1, title: "Test", body: "Test")]
        self.mockNetworkService.result = .success(expectedPosts)
        
        self.service.fetchPosts(userId: 1) { result in
            switch result {
            case .success(let posts):
                XCTAssertEqual(posts, expectedPosts)
            case .failure:
                XCTFail("Expected successful response")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    }
}
