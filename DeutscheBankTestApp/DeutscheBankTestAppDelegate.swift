//
//  DeutscheBankTestAppDelegate.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

@main
struct DeutscheBankTestAppDelegate: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
