//
//  LoginView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var userID: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField(LocalizableManager.enterUserID, text: $userID)
                    .keyboardType(.numberPad)
                    .padding()
                    .cornerRadius(Constants.UIConstants.baseCornerRadius)
                    .border(Color.gray, width: 0.5)
                Spacer()
                NavigationLink(destination: PostsView(viewModel: PostsViewModel(userID: Int(self.userID) ?? 0))) {
                    Text(LocalizableManager.showPosts)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(Constants.UIConstants.baseCornerRadius)
                Spacer()
            }
            .padding()
            .navigationBarTitle(LocalizableManager.welcomeTitle)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
