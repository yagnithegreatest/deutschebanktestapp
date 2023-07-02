//
//  Post.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import Foundation

final class Post: Identifiable, ObservableObject, Equatable {
    
    init(
        userId: Int,
         id: Int,
         title: String,
         body: String,
        isFavorite: Bool
    ) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
    }
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    @Published var isFavorite: Bool
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.userId == rhs.userId && lhs.id == rhs.id
    }
}
