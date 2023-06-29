//
//  PostsViewModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var errorViewTitle: String? = nil
    
    private var userID: Int

    private let networkService: PostsNetworkServiceProtocol
    
    init(networkService: PostsNetworkServiceProtocol = ServiceLocator.shared.getService(), userID: Int) {
        
        self.networkService = networkService
        self.userID = userID
    }
    
    func fetchPosts(userId: Int) {
        
        self.isLoading = true
        
        self.networkService.fetchPosts(userId: userId) { result in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                switch result {
                case .success(let posts):
                    self.posts = posts
                case .failure(let error):
                    
                    self.error = error
                    self.errorViewTitle = "Error loading posts"
                }
            }
        }
    }
}
