//
//  PostDataManagerTests.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

@testable import DeutscheBankTestApp
import CoreData
import Foundation
import XCTest

final class PostDataManagerTests: XCTestCase {
    
    var mockCoreDataManager: MockCoreDataManager!
    var postDataManager: PostDataManager!
    
    override func setUp() {
        super.setUp()
        
        self.mockCoreDataManager = MockCoreDataManager()
        self.postDataManager = PostDataManager(manager: self.mockCoreDataManager)
    }
    
    override func tearDown() {
        self.mockCoreDataManager = nil
        self.postDataManager = nil
        super.tearDown()
    }
    
    func testSavePost() {
        
        let post = Post(userId: 1, id: 1, title: "Test Title", body: "Test Body", isFavorite: true)
        let expectation = self.expectation(description: "Saving post")

        self.postDataManager.savePost(post) { result in
            XCTAssertTrue(self.mockCoreDataManager.isSaveCalled)
            XCTAssertNoThrow {
                do {
                    let _ = try result.get()
                } catch {
                    XCTFail("Expected function to not throw, but it did throw: \(error)")
                }
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchFavoritePosts() {
        
        let result = self.postDataManager.fetchFavoritePosts()
        
        XCTAssertTrue(self.mockCoreDataManager.isFetchCalled)
        XCTAssertNotNil(result)
    }
    
    func testDeletePost() {
        
        let post = Post(userId: 1, id: 1, title: "Test Title", body: "Test Body", isFavorite: true)
        let expectation = self.expectation(description: "Deleting post")

        self.postDataManager.deletePost(post) { result in
            
            XCTAssertTrue(self.mockCoreDataManager.isDeleteCalled)
            
            XCTAssertNoThrow {
                do {
                    let _ = try result.get()
                } catch {
                    XCTFail("Expected function to not throw, but it did throw: \(error)")
                }
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
