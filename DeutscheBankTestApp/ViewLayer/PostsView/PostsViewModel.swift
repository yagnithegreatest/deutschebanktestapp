//
//  PostsViewModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

class PostsViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = ServiceLocator.shared.getService()) {
        self.networkService = networkService
    }
    
    func fetchPosts(userId: Int) {
        
        networkService.request(PostsRequest(userId: userId)) { (result: Result<[Post], Error>) in
            
            switch result {
                
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print(error.localizedDescription)  // handle error properly in a real app
            }
        }
    }
}
