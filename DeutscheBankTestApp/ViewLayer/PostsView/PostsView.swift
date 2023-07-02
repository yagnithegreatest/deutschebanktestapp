//
//  PostsView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct PostsView: View {
    
    @EnvironmentObject var userSession: UserSession
    
    // MARK: - Init
    @ObservedObject var viewModel: PostsViewModel
    
    // MARK: - Body
    var body: some View {
        Group {
            switch self.viewModel.state {
            case .loading:
                LoadingView()
            case .loaded:
                
                if self.viewModel.posts.isEmpty {
                    EmptyStateView(title: self.viewModel.fetchFavoritesOnly ? LocalizableManager.noFavoritesYet : LocalizableManager.noPostsForThisUser)
                } else {
                    self.postsList()
                }
            case .error(let error):
                ErrorView(error: error)
            }
        }
        .onAppear {
            // Update the posts fav status every time switching the tabs
            self.viewModel.state = .loading
            self.viewModel.fetchPosts()
        }
        .navigationBarItems(trailing: self.logoutButton)
    }
    
    // MARK: - Private methods
    private var logoutButton: some View {
        
        Button(action: {
            self.userSession.isLoggedIn = false
        }) {
            Text(LocalizableManager.logout)
            Image(systemName: ImageManager.houseFill)
                .foregroundColor(ColorHelper.brandColor)
        }
    }
    
    private func postsList() -> some View {
        
        List {
            ForEach(Array(self.viewModel.posts.enumerated()), id: \.1.id) { index, post in
                Section {
                    SinglePostView(post: post) { updatedPost in
                        self.viewModel.toggleFavorite(at: index, with: updatedPost)
                    }

                    NavigationLink(
                        destination: CommentsView(
                            post: post,
                            viewModel: CommentsViewModel(),
                            toggleFavorite: { updatedPost in
                                self.viewModel.toggleFavorite(at: index, with: updatedPost)
                            }
                        )
                    ) {
                        Text(LocalizableManager.comments)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(self.viewModel.title)
    }
}
