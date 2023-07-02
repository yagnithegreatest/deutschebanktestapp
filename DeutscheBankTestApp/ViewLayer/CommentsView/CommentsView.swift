//
//  CommentsView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

import SwiftUI

struct CommentsView: View {
    
    @ObservedObject var post: Post
    @ObservedObject var viewModel: CommentsViewModel
    
    let toggleFavorite: (Post) -> Void
    
    var body: some View {
        
        VStack {
            
            SinglePostView(post: self.post, toggleFavorite: self.toggleFavorite)
                .padding()
            
            Group {
                switch self.viewModel.state {
                case .loading:
                    LoadingView()
                case .loaded:
                    if self.viewModel.comments.isEmpty {
                        EmptyStateView(title: LocalizableManager.noComments)
                    } else {
                        List(self.viewModel.comments, id: \.id) { comment in
                            SingleCommentView(comment: comment)
                        }
                    }
                case .error(let error):
                    Spacer()
                    ErrorView(error: error)
                    Spacer()
                }
            }
        }.onAppear {
            self.viewModel.fetchComments(for: post.id)
        }
        .navigationTitle(LocalizableManager.comments)
    }
}
