//
//  CommentsNetworkServiceTest.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import XCTest

final class CommentsNetworkServiceTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService<[Comment]>!
    var service: CommentsNetworkService!

    override func setUp() {
        super.setUp()
        self.mockNetworkService = MockNetworkService<[Comment]>()
        self.service = CommentsNetworkService(networkService: self.mockNetworkService)
    }

    override func tearDown() {
        self.mockNetworkService = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchComments() {
        
        let expectation = self.expectation(description: "Comments Network Service Test")
        
        let expectedComments = [Comment(postId: 1, id: 1, name: "Test", email: "test@email.com", body: "Comment body")]
        self.mockNetworkService.result = .success(expectedComments)
        
        self.service.fetchComments(postId: 1) { result in
            switch result {
            case .success(let comments):
                XCTAssertEqual(comments, expectedComments)
            case .failure:
                XCTFail("Expected successful response")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    }
}
