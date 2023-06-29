//
//  DeutscheBankTestAppDelegate.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

@main
struct DeutscheBankTestAppDelegate: App {
    
    init() {
        addDependencies()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

    private func addDependencies() {
        
        let networkService = NetworkService()
        ServiceLocator.shared.addService(networkService as NetworkServiceProtocol)

        let postsNetworkService = PostsNetworkService(networkService: networkService)
        ServiceLocator.shared.addService(postsNetworkService as PostsNetworkServiceProtocol)

        let commentsNetworkService = CommentsNetworkService(networkService: networkService)
        ServiceLocator.shared.addService(commentsNetworkService as CommentsNetworkServiceProtocol)
    }
}
