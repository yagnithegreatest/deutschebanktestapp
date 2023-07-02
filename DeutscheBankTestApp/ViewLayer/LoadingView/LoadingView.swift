//
//  LoadingView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            ProgressView()
            Text(LocalizableManager.basicLoadingTitle)
                .font(.title)
                .padding(.top)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
