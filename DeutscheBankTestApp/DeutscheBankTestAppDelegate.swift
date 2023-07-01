//
//  DeutscheBankTestAppDelegate.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

@main
struct DeutscheBankTestAppDelegate: App {
    
    @StateObject private var userSession = UserSession()
    
    init() {
        self.addDependencies()
    }

    var body: some Scene {
        
        WindowGroup {
            EntryView()
                .environmentObject(self.userSession)
        }
    }

    private func addDependencies() {
        
        let networkService = NetworkService()
        ServiceLocator.shared.addService(networkService as NetworkServiceProtocol)

        let postsNetworkService = PostsNetworkService(networkService: networkService)
        ServiceLocator.shared.addService(postsNetworkService as PostsNetworkServiceProtocol)

        let commentsNetworkService = CommentsNetworkService(networkService: networkService)
        ServiceLocator.shared.addService(commentsNetworkService as CommentsNetworkServiceProtocol)
        
        let postDataManager = PostDataManager()
        ServiceLocator.shared.addService(postDataManager as PostDataManagerProtocol)
        
        let coreDataManager = CoreDataManager()
        ServiceLocator.shared.addService(coreDataManager as CoreDataManagerProtocol)
    }
}
