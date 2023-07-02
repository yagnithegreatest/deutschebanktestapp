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
        
        let reachabilityManager: ReachabilityManagerProtocol = ServiceLocator.shared.getService()
        reachabilityManager.startNetworkReachabilityObserver()
    }

    var body: some Scene {
        
        WindowGroup {
            EntryView()
                .environmentObject(self.userSession)
        }
    }

    private func addDependencies() {
        
        let reachabilityManager = ReachabilityManager()
        ServiceLocator.shared.addService(reachabilityManager as ReachabilityManagerProtocol)
        
        let networkSession = NetworkSession()
        ServiceLocator.shared.addService(networkSession as NetworkSessionProtocol)
        
        let networkService = NetworkService()
        ServiceLocator.shared.addService(networkService as NetworkServiceProtocol)

        let postsNetworkService = PostsNetworkService(networkService: networkService)
        ServiceLocator.shared.addService(postsNetworkService as PostsNetworkServiceProtocol)

        let commentsNetworkService = CommentsNetworkService(networkService: networkService)
        ServiceLocator.shared.addService(commentsNetworkService as CommentsNetworkServiceProtocol)
        
        let coreDataManager = CoreDataManager()
        ServiceLocator.shared.addService(coreDataManager as CoreDataManagerProtocol)
        
        let postDataManager = PostDataManager()
        ServiceLocator.shared.addService(postDataManager as PostDataManagerProtocol)
    }
}
