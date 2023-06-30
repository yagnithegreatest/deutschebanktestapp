//
//  UserSession.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import SwiftUI

class UserSession: ObservableObject {
    @Published var userID: Int? = nil
    @Published var isLoggedIn: Bool = false
}   
