//
//  MockPostsViewModel.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

@testable import DeutscheBankTestApp
import Foundation

final class MockPostsViewModel: PostsViewModelProtocol {
    
    var posts: [Post] = []
    var state: ViewModelState = .loading
    var title: String = ""
    var networkService: PostsNetworkServiceProtocol
    var postDataManager: PostDataManagerProtocol
    var fetchPostsCalled = false
    var toggleFavoriteCalled = false
    var toggleFavoriteAtIndex: Int?
    var toggleFavoritePost: Post?
    
    init(
        networkService: PostsNetworkServiceProtocol = MockPostsNetworkService(),
        postDataManager: PostDataManagerProtocol = MockPostDataManager()
    ) {
        self.networkService = networkService
        self.postDataManager = postDataManager
    }
    
    func fetchPosts() {
        
        self.fetchPostsCalled = true
        
        self.networkService.fetchPosts(userId: 1) { [weak self] result in
            switch result {
            case .success(let postAPIModels):
                self?.posts = postAPIModels.map { postAPIModel in
                    
                    var isFavorite = false
                    
                    switch self?.postDataManager.isPostFavorited(id: postAPIModel.id, userID: postAPIModel.userId) {
                    case .success(let favorited):
                        isFavorite = favorited
                    case .failure(let error):
                        print("Failed to check if post is favorited: \(error)")
                    case .none:
                        print("Failed to check if post is favorited: optional self is nil")
                    }
                    
                    return Post(
                        userId: postAPIModel.userId,
                        id: postAPIModel.id,
                        title: postAPIModel.title,
                        body: postAPIModel.body,
                        isFavorite: isFavorite
                    )
                }
            case .failure(let error):
                print("Failed to fetch posts: \(error)")
            }
        }
    }
    
    func toggleFavorite(at index: Int, with post: Post) {
        
        self.toggleFavoriteCalled = true
        
        if index < self.posts.count {
            self.posts[index].isFavorite.toggle()
        }
    }
}
