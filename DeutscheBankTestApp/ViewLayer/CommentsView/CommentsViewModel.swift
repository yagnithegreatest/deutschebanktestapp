//
//  CommentsViewModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

import Foundation

class CommentsViewModel: ObservableObject {

    @Published var comments: [Comment] = []
    @Published var isLoading: Bool = false

    private var commentsNetworkService: CommentsNetworkServiceProtocol

    init(commentsNetworkService: CommentsNetworkServiceProtocol = ServiceLocator.shared.getService()) {
        self.commentsNetworkService = commentsNetworkService
    }

    func fetchComments(for postId: Int) {
        self.isLoading = true
        self.commentsNetworkService.fetchComments(postId: postId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self?.comments = comments
                case .failure(let error):
                    print("Failed to fetch comments: \(error)")
                    self?.comments = []
                }
                self?.isLoading = false
            }
        }
    }
}