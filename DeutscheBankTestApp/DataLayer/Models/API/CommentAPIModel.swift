//
//  CommentAPIModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

struct Comment: Codable, Identifiable, Equatable {
    
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
