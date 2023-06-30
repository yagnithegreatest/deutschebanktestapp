//
//  FavButton.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct FavButton: View {
    
    var isFavorite: Bool
    var onTap: () -> Void
    
    var body: some View {
        
        Button(action: self.onTap) {
            
            Image(systemName: self.isFavorite ? ImageManager.starFilled : ImageManager.starEmpty)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(self.isFavorite ? .yellow : .gray)
        }
    }
}
