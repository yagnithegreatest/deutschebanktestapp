//
//  ErrorView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct ErrorView: View {
    
    // MARK: - Init
    let error: Error
    
    // MARK: - Private properties
    private var errorMessage: String {
        
        if let networkError = self.error as? NetworkError {
            return networkError.localizedDescription
        } else {
            return self.error.localizedDescription
        }
    }
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            Image(systemName: ImageManager.errorMark)
                .resizable()
                .frame(width: 50, height: 50)
            Text(LocalizableManager.basicErrorTitle)
                .font(.title)
                .padding(.top)
            Text(self.errorMessage)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
