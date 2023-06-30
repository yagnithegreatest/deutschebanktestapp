//
//  NetworkServiceTest.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

@testable import DeutscheBankTestApp
import XCTest

final class NetworkServiceTest: XCTestCase {
    
    func testNetworkService() {

        let expectedPost = PostAPIModel(userId: 1, id: 1, title: "Test", body: "Test")
        let mockSession = MockNetworkSession()
        
        mockSession.requestHandler = { _, _, _, _, _ in
            let encoder = JSONEncoder()
            let data = try! encoder.encode([expectedPost])
            return (data, nil)
        }
        
        let networkService = NetworkService(networkSession: mockSession)
        let request = PostsRequest(userId: 1)
        

        networkService.request(request) { (result: Result<[PostAPIModel], Error>) in

            switch result {
                
            case .success(let posts):
                XCTAssertEqual(posts, [expectedPost])
            case .failure:
                XCTFail("Expected successful response")
            }
        }
    }
}
