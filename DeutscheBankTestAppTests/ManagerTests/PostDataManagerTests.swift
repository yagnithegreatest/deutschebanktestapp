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

class PostDataManagerTests: XCTestCase {
    
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
        let result = self.postDataManager.savePost(post)
        
        XCTAssertTrue(self.mockCoreDataManager.isSaveCalled)
        XCTAssertNotNil(result)
        XCTAssertNoThrow(try result.get())
    }
    
    func testFetchFavoritePosts() {
        
        let result = self.postDataManager.fetchFavoritePosts()
        
        XCTAssertTrue(self.mockCoreDataManager.isFetchCalled)
        XCTAssertNotNil(result)
    }
    
    func testDeletePost() {
        
        let post = Post(userId: 1, id: 1, title: "Test Title", body: "Test Body", isFavorite: true)
        let result = self.postDataManager.deletePost(post)
        
        XCTAssertTrue(self.mockCoreDataManager.isDeleteCalled)
        XCTAssertNotNil(result)
        XCTAssertNoThrow(try result.get())
    }
}
