//
//  LoginView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userSession: UserSession
    @State private var inputUserID: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(LocalizableManager.enterUserID, text: $inputUserID)
                    .keyboardType(.numberPad)
                    .padding()
                    .border(.gray)
                
                Button(LocalizableManager.showPosts) {
                    self.userSession.userID = Int(self.inputUserID)
                    self.userSession.isLoggedIn = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(Constants.UIConstants.baseCornerRadius)
            }
            .navigationBarTitle(LocalizableManager.welcomeTitle)
        }
        .padding()
    }
}
