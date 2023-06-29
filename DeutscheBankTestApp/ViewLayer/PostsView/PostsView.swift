//
//  PostsView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct PostsView: View {
    
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        Group {
            if self.viewModel.isLoading {
                LoadingView()
            } else {
                Group {
                    if let error = self.viewModel.error {
                        ErrorView(error: error, title: self.viewModel.errorViewTitle)
                    } else {
                        List(self.viewModel.posts, id: \.id) { post in
                            Text(post.title)
                        }
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.fetchPosts(userId: 1)
        }
    }
}
