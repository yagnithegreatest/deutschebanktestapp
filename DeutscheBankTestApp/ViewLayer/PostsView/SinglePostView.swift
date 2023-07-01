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
        
        
        VStack(alignment: .leading) {
            
            HStack {
                
                Text("UserID: \(post.userId), ID: \(post.id)")
                    .font(FontManager.lightSecondaryFont)
                    .padding(.top, Constants.UIConstants.defaultPadding)
                
                Spacer()
                
                FavButton(isFavorite: self.post.isFavorite) {
                    self.toggleFavorite(self.post)
                }
                .padding([.leading, .top])
            }

            Text(post.title)
                .font(FontManager.mainTitleFont)
                .padding([.bottom, .top], Constants.UIConstants.defaultPadding)
            
            Text(LocalizableManager.spacer + post.body)
                .font(FontManager.mainBodyFont)
                .foregroundColor(Color.gray)
        }
        .padding(Constants.UIConstants.smallerPadding)
    }
    
}


