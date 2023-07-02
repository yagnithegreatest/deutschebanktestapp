//
//  ViewModelState.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 02.07.2023.
//

import Foundation

enum ViewModelState {
    case loading
    case loaded
    case error(Error)
}
