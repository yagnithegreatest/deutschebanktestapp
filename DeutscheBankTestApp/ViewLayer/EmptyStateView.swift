//
//  EmptyStateView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct EmptyStateView: View {
    
    // MARK: - Init
    let title: String
    
    // MARK: - Body
    var body: some View {
        Text(self.title)
            .multilineTextAlignment(.center)
            .padding()
    }
}
