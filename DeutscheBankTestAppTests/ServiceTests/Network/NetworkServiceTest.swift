//
//  NetworkServiceTest.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import XCTest

final class NetworkServiceTest: XCTestCase {
    
    var mockSession: MockNetworkSession!
    
    override func setUp() {
        super.setUp()
        self.mockSession = MockNetworkSession()
    }
    
    override func tearDown() {
        self.mockSession = nil
        super.tearDown()
    }
    
    func testNetworkService() {
        let expectation = self.expectation(description: "Network Service Test")
        
        let expectedPost = PostAPIModel(userId: 1, id: 1, title: "Test", body: "Test")
        self.mockSession.requestHandler = { _, _, _, _, _ in
            let encoder = JSONEncoder()
            let data = try! encoder.encode([expectedPost])
            return (data, nil)
        }
        
        let networkService = NetworkService(networkSession: self.mockSession)
        let request = PostsRequest(userId: 1)
        
        networkService.request(request) { (result: Result<[PostAPIModel], Error>) in
            switch result {
            case .success(let posts):
                XCTAssertEqual(posts, [expectedPost])
            case .failure:
                XCTFail("Expected successful response")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    }
}

