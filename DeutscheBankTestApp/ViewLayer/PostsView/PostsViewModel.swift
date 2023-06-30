//
//  PostsViewModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

enum ViewModelState {

    case loading
    case loaded
    case error(Error)
}

final class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var state: ViewModelState = .loading
    @Published var title: String
    let fetchFavoritesOnly: Bool
    
    private let networkService: PostsNetworkServiceProtocol
    private let postDataManager: PostDataManagerProtocol
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
            postDataManager.deletePost(post) { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        if self?.fetchFavoritesOnly == true {
                            self?.posts.remove(at: index)
                        } else {
                            self?.posts[index].isFavorite = false
                        }
                    }
                }
            }
        } else {
            postDataManager.savePost(post) { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        self?.posts[index].isFavorite = true
                    }
                }
            }
        }
    }
    
    func fetchPosts() {
        
        guard case .loading = self.state else { return }
        
        if fetchFavoritesOnly {
            DispatchQueue.main.async {
                self.posts = self.postDataManager.fetchFavoritePosts()
                self.state = .loaded
            }
        } else {
            self.networkService.fetchPosts(userId: self.userID) { [weak self] result in
                
                DispatchQueue.main.async {
                    
                    switch result {
                    case .success(let posts):
                        self?.posts = posts.map {
                            Post(userId: $0.userId,
                                 id: $0.id,
                                 title: $0.title,
                                 body: $0.body,
                                 isFavorite: (self?.postDataManager.isPostFavorited(id: $0.id, userID: $0.userId))!) }
                        self?.state = .loaded
                    case .failure(let error):
                        self?.state = .error(error)
                    }
                }
            }
        }
    }
}
