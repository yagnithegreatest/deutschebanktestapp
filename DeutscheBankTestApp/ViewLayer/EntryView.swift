//
//  EntryView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import SwiftUI

struct EntryView: View {
    
    @EnvironmentObject var userSession: UserSession
    
    // MARK: - Body
    var body: some View {
        if self.userSession.isLoggedIn {
            MainTabView().environmentObject(self.userSession)
        } else {
            LoginView().environmentObject(self.userSession)
        }
    }
}
