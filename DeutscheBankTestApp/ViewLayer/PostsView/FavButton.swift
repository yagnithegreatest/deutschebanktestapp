//
//  FavButton.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct FavButton: View {
    
    @State var isFavorite: Bool
    
    var body: some View {
        
        Button(action: {
            self.isFavorite.toggle()
        }) {
            
            Image(systemName: self.isFavorite ? ImageManager.starFilled : ImageManager.starEmpty)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(self.isFavorite ? .yellow : .gray)
        }
    }
}
