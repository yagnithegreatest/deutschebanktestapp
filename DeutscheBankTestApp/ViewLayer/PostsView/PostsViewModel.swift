//
//  PostsViewModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

protocol PostsViewModelProtocol {
    
    var posts: [Post] { get }
    var state: ViewModelState { get }
    var title: String { get }
    var networkService: PostsNetworkServiceProtocol { get }
    var postDataManager: PostDataManagerProtocol { get }
    
    func fetchPosts()
    func toggleFavorite(at index: Int, with post: Post)
}

final class PostsViewModel: ObservableObject, PostsViewModelProtocol {
    
    @Published var posts: [Post] = []
    @Published var state: ViewModelState = .loading
    @Published var title: String
    let fetchFavoritesOnly: Bool
    
    let networkService: PostsNetworkServiceProtocol
    let postDataManager: PostDataManagerProtocol
    
    private let userID: Int
    
    init(
        userID: Int,
        title: String,
        fetchFavoritesOnly: Bool = false,
        networkService: PostsNetworkServiceProtocol = ServiceLocator.shared.getService(),
        postDataManager: PostDataManagerProtocol = ServiceLocator.shared.getService()
    ) {
        
        self.networkService = networkService
        self.userID = userID
        self.title = title
        self.postDataManager = postDataManager
        self.fetchFavoritesOnly = fetchFavoritesOnly
    }
    
    func toggleFavorite(at index: Int, with post: Post) {
        if post.isFavorite {
            switch self.postDataManager.deletePost(post) {
                
            case .success():
                DispatchQueue.main.async {
                    if self.fetchFavoritesOnly == true {
                        self.posts.remove(at: index)
                    } else {
                        self.posts[index].isFavorite = false
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .error(error)
            }
        } else {
            
            switch self.postDataManager.savePost(post) {
            case .success():
                DispatchQueue.main.async {
                    self.posts[index].isFavorite = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .error(error)
            }
        }
    }
    
    func fetchPosts() {
        
        guard case .loading = self.state else { return }
        
        if self.fetchFavoritesOnly {
            
            switch self.postDataManager.fetchFavoritePosts() {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                    self.state = .loaded
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .error(error)
            }
        } else {
            self.networkService.fetchPosts(userId: self.userID) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let posts):
                        self?.posts = posts.map { post in
                            var isFavorite = false
                            switch self?.postDataManager.isPostFavorited(id: post.id, userID: post.userId) {
                            case .success(let favorited):
                                isFavorite = favorited
                            case .failure(let error):
                                print("Failed to check if post is favorited: \(error)")
                                self?.state = .error(error)
                            case .none:
                                print("Failed to check if post is favorited: optional self is nil")
                            }
                            return Post(userId: post.userId,
                                        id: post.id,
                                        title: post.title,
                                        body: post.body,
                                        isFavorite: isFavorite)
                        }
                        self?.state = .loaded
                    case .failure(let error):
                        self?.state = .error(error)
                    }
                }
            }
        }
    }
}
