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
    
    private let networkService: PostsNetworkServiceProtocol
    private let userID: Int
    
    init(userID: Int, title: String, networkService: PostsNetworkServiceProtocol = ServiceLocator.shared.getService()) {
        self.networkService = networkService
        self.userID = userID
        self.title = title
    }
    
    func fetchPosts() {
        
        guard case .loading = self.state else { return }
        
        self.networkService.fetchPosts(userId: self.userID) { [weak self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let posts):
                    self?.posts = posts
                    self?.state = .loaded
                case .failure(let error):
                    self?.state = .error(error)
                }
            }
        }
    }
}
