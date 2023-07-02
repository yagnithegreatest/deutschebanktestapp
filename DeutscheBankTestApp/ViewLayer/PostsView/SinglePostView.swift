//
//  SinglePostView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct SinglePostView: View {
    
    // MARK: - Init
    @ObservedObject var post: Post
    let toggleFavorite: (Post) -> Void
    
    // MARK: - Body
    var body: some View {

        let userIDString = NonLocalizableManager.userID + String(self.post.userId)
        let postIDString = NonLocalizableManager.postId + String(self.post.id)
        
        VStack(alignment: .leading) {
            
            HStack {
                
                Text(userIDString + "," + postIDString)
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
            
            Text(post.body)
                .font(FontManager.mainBodyFont)
                .foregroundColor(ColorHelper.secondaryFontColor)
        }
        .padding(Constants.UIConstants.smallerPadding)
    }
}
