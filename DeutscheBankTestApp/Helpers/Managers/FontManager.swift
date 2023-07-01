//
//  FontManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import SwiftUI

struct FontManager {
    
    static var mainTitleFont: Font {
        return Font.system(size: 14, weight: .regular)
    }
    
    static var mainBodyFont: Font {
        return Font.system(size: 12, weight: .light)
    }
    
    static var lightSecondaryFont: Font {
        return Font.system(size: 11, weight: .ultraLight)
    }
}
