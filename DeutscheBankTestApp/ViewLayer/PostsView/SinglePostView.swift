//
//  SinglePostView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct SinglePostView: View {
    
    @ObservedObject var post: Post
    let toggleFavorite: (Post) -> Void
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(FontManager.mainTitleFont)
                    .padding([.bottom, .top], Constants.UIConstants.defaultPadding)
                
                Text(LocalizableManager.spacer + post.body)
                    .font(FontManager.mainBodyFont)
                    .foregroundColor(Color.gray)
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                FavButton(isFavorite: self.post.isFavorite) {
                    self.toggleFavorite(self.post)
                }
                .padding([.leading, .top])
                
                Spacer()
            }
        }
        .padding(Constants.UIConstants.smallerPadding)
    }
}

