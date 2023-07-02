//
//  PostsViewModelTests.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

@testable import DeutscheBankTestApp
import Foundation
import XCTest

final class PostsViewModelTests: XCTestCase {
    
    var mockNetworkService: MockPostsNetworkService!
    var mockDataManager: MockPostDataManager!
    
    override func setUp() {
        super.setUp()
        
        self.mockNetworkService = MockPostsNetworkService()
        self.mockDataManager = MockPostDataManager()
    }
    
    override func tearDown() {
        
        self.mockNetworkService = nil
        self.mockDataManager = nil
        super.tearDown()
    }
    
    func testFetchPosts() {
            
        let mockViewModel = MockPostsViewModel(networkService: mockNetworkService, postDataManager: mockDataManager)

        let postAPIModel1 = DeutscheBankTestApp.PostAPIModel(userId: 1, id: 1, title: "Title1", body: "Body1")
        let postAPIModel2 = DeutscheBankTestApp.PostAPIModel(userId: 1, id: 2, title: "Title2", body: "Body2")
        self.mockNetworkService.postAPIModels = [postAPIModel1, postAPIModel2]

        let post1 = Post(userId: postAPIModel1.userId, id: postAPIModel1.id, title: postAPIModel1.title, body: postAPIModel1.body, isFavorite: true)
        let post2 = Post(userId: postAPIModel2.userId, id: postAPIModel2.id, title: postAPIModel2.title, body: postAPIModel2.body, isFavorite: false)
        
        self.mockDataManager.savedPosts = [post1, post2]

        mockViewModel.fetchPosts()

        XCTAssertEqual(mockViewModel.posts,
                       [Post(userId: postAPIModel1.userId, id: postAPIModel1.id, title: postAPIModel1.title, body: postAPIModel1.body, isFavorite: true),
                        Post(userId: postAPIModel2.userId, id: postAPIModel2.id, title: postAPIModel2.title, body: postAPIModel2.body, isFavorite: false)])
    }
    
    func testToggleFavorite() {
        
        let mockViewModel = MockPostsViewModel(networkService: mockNetworkService, postDataManager: mockDataManager)
        
        let postAPIModel = PostAPIModel(userId: 1, id: 1, title: "Title1", body: "Body1")
        var isFav: Bool
        
        switch mockDataManager.isPostFavorited(id: postAPIModel.id, userID: postAPIModel.userId) {
        case .success(let status):
            isFav = status
        case .failure(_):
            isFav = false
        }
        
        let post = Post(userId: postAPIModel.userId, id: postAPIModel.id, title: postAPIModel.title, body: postAPIModel.body, isFavorite: isFav)
        
        mockNetworkService.postAPIModels = [postAPIModel]
        
        mockViewModel.posts = [post]
        
        let expectation = self.expectation(description: "Toggling favorite status")
        
        mockViewModel.toggleFavorite(at: 0, with: post)
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
            
            XCTAssertTrue(mockViewModel.toggleFavoriteCalled)
            XCTAssertTrue(mockViewModel.posts[0].isFavorite)
        }
    }
}
