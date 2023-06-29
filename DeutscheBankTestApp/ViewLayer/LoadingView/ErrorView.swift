//
//  ErrorView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    let title: String?
    
    var body: some View {
        
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 50, height: 50)
            Text(title ?? "Oops! An error occurred.")
                .font(.title)
                .padding(.top)
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
