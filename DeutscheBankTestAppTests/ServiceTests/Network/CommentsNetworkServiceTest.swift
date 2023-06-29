//
//  CommentsNetworkServiceTest.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import XCTest

final class CommentsNetworkServiceTest: XCTestCase {
    
    func testFetchComments() {

        let expectedComments = [Comment(postId: 1, id: 1, name: "Test", email: "test@email.com", body: "Comment body")]
        
        let mockNetworkService = MockNetworkService<[Comment]>()
        mockNetworkService.result = .success(expectedComments)
        
        let service = CommentsNetworkService(networkService: mockNetworkService)
        
        var postArray: [Comment]?
        
        service.fetchComments(postId: 1) { result in
            
            switch result {
            case .success(let posts):
                postArray = posts
            case .failure:
                postArray = nil
            }
        }
        
        XCTAssertEqual(postArray, expectedComments)
    }
}
