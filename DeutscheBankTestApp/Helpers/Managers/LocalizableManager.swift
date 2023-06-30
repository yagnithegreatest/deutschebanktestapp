//
//  LocalizableManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 29.06.2023.
//

import Foundation

struct LocalizableManager {
    
    static var welcomeTitle: String {
        return NSLocalizedString("welcome_title", comment: "")
    }
    
    static var enterUserID: String {
        return NSLocalizedString("enter_user_id", comment: "")
    }
    
    static var showPosts: String {
        return NSLocalizedString("show_posts", comment: "")
    }

    static var myPostsTitle: String {
        NSLocalizedString("My posts", comment: "")
    }
    
    static var all: String {
        NSLocalizedString("All", comment: "")
    }
    
    static var favorite: String {
        NSLocalizedString("Favorite", comment: "")
    }
    
    static var comments: String {
        NSLocalizedString("Comments", comment: "")
    }
    
    static var basicErrorTitle: String {
        NSLocalizedString("basic_error_title", comment: "")
    }
    
    static var basicLoadingTitle: String {
        NSLocalizedString("basic_loading_title", comment: "")
    }
    
    static var spacer: String {
        NSLocalizedString("spacer", comment: "")
    }
    
    static var noPostsForThisUser: String {
        NSLocalizedString("no_posts_for_this_user", comment: "")
    }
    
    static var logout: String {
        NSLocalizedString("logout", comment: "")
    }
}
