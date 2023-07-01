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
            if self.viewModel.isLoading {
                LoadingView()
            } else {
                List(self.viewModel.comments, id: \.id) { comment in
                    SingleCommentView(comment: comment)
                }
            }
        }.onAppear {
            self.viewModel.fetchComments(for: post.id)
        }
        .navigationTitle(LocalizableManager.comments)
    }
}
