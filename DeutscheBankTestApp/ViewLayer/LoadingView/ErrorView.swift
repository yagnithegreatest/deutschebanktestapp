//
//  ErrorView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    var body: some View {
        
        VStack {
            Image(systemName: ImageManager.errorMark)
                .resizable()
                .frame(width: 50, height: 50)
            Text(LocalizableManager.basicErrorTitle)
                .font(.title)
                .padding(.top)
            Text(self.error.localizedDescription)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
