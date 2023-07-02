//
//  TabView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var userSession: UserSession
    
    // MARK: - Private properties
    @State private var selectedTab = 0
    
    // MARK: - Body
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            NavigationView {
                PostsView(viewModel: PostsViewModel(userID: self.userSession.userID ?? 1, title: LocalizableManager.myPostsTitle))
            }
            .tabItem {
                Image(systemName: ImageManager.list)
                Text(LocalizableManager.all)
            }
            .tag(0)
            
            NavigationView {
                PostsView(viewModel: PostsViewModel(userID: self.userSession.userID ?? 2, title: LocalizableManager.favorite, fetchFavoritesOnly: true))
            }
            .tabItem {
                Image(systemName: ImageManager.starFilled)
                Text(LocalizableManager.favorite)
            }
            .tag(1)
        }
    }
}
