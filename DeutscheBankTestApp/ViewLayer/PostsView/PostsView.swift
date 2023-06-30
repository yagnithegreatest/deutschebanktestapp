//
//  PostsView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct PostsView: View {
    
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        Group {
            switch self.viewModel.state {
            case .loading:
                LoadingView()
            case .loaded:
                
                if self.viewModel.posts.isEmpty {
                    EmptyStateView(title: LocalizableManager.noPostsForThisUser)
                } else {
                    self.postsList()
                }
            case .error(let error):
                ErrorView(error: error)
            }
        }
        .onAppear {
            if case .loading = self.viewModel.state {
                self.viewModel.fetchPosts()
            }
        }
        .navigationBarItems(trailing: logoutButton)
    }
    
    private var logoutButton: some View {
        
        Button(action: {
            self.userSession.isLoggedIn = false
        }) {
            Text(LocalizableManager.logout)
            Image(systemName: "house.fill")
                .foregroundColor(.blue)
        }
    }
    
    private func postsList() -> some View {
        
        List(self.viewModel.posts, id: \.id) { post in
            SinglePostView(post: post)
        }
        .navigationTitle(self.viewModel.title)
    }
}
