//
//  EntryView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import SwiftUI

struct EntryView: View {
    
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        if self.userSession.isLoggedIn {
            MainTabView().environmentObject(userSession)
        } else {
            LoginView().environmentObject(userSession)
        }
    }
}
