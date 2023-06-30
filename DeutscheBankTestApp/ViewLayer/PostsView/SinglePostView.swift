//
//  SinglePostView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct SinglePostView: View {
    
    @State var post: Post
    @State var isFav: Bool = false
    
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
                FavButton(isFavorite: self.isFav)
                    .padding([.leading, .top])
                
                Spacer()
            }
        }
        .padding(Constants.UIConstants.smallerPadding)
    }
}

