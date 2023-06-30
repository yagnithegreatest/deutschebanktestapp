//
//  PostAPIModel.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

struct PostAPIModel: Codable, Identifiable, Equatable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
