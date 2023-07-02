//
//  CommentsViewModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

import Foundation

final class CommentsViewModel: ObservableObject {

    // MARK: - Public properties
    @Published var comments: [Comment] = []
    @Published var state: ViewModelState = .loading

    // MARK: - Private properties
    private var commentsNetworkService: CommentsNetworkServiceProtocol

    // MARK: - Init
    init(commentsNetworkService: CommentsNetworkServiceProtocol = ServiceLocator.shared.getService()) {
        self.commentsNetworkService = commentsNetworkService
    }

    // MARK: - API
    func fetchComments(for postId: Int) {
        self.state = .loading
        self.commentsNetworkService.fetchComments(postId: postId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self?.comments = comments
                    self?.state = .loaded
                case .failure(let error):
                    print("Failed to fetch comments: \(error)")
                    self?.comments = []
                    self?.state = .error(error)
                }
            }
        }
    }
}
