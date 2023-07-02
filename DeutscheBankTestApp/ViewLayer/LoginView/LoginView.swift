//
//  LoginView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userSession: UserSession
    
    // MARK: - Private properties
    @State private var inputUserID: String = ""
    
    // MARK: - Body
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
                .background(ColorHelper.brandColor)
                .foregroundColor(ColorHelper.accentFontColor)
                .cornerRadius(Constants.UIConstants.baseCornerRadius)
                .opacity(self.inputUserID.isEmpty ? 0.5 : 1.0)
                .disabled(self.inputUserID.isEmpty)
            }
            .navigationBarTitle(LocalizableManager.welcomeTitle)
        }
        .padding()
    }
}
