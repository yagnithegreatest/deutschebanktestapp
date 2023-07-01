//
//  SingleCommentView.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

import SwiftUI

struct SingleCommentView: View {
    
    let comment: Comment
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(self.comment.email)
                .font(FontManager.lightSecondaryFont)
                .padding(.top, Constants.UIConstants.defaultPadding)
            
            Text(self.comment.name)
                .font(FontManager.mainTitleFont)
                .padding([.bottom], Constants.UIConstants.defaultPadding)
            
            Text(LocalizableManager.spacer + comment.body)
                .font(FontManager.mainBodyFont)
                .foregroundColor(Color.gray)
        }
        
    }
}
