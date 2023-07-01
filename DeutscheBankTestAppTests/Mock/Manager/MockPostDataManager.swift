//
//  MockPostDataManager.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

@testable import DeutscheBankTestApp
import Foundation

final class MockPostDataManager: PostDataManagerProtocol {
    
    var savedPosts: [Post] = []
    
    func isPostFavorited(id: Int, userID: Int) -> Result<Bool, Error> {
        
        let favorited = self.savedPosts.contains { $0.id == id && $0.userId == userID && $0.isFavorite }
        
        return .success(favorited)
    }

    func savePost(_ post: Post) -> Result<Void, Error> {
        
        if let index = self.savedPosts.firstIndex(where: { $0.id == post.id && $0.userId == post.userId }) {
            self.savedPosts[index] = post
        } else {
            self.savedPosts.append(post)
        }
        
        return .success(())
    }

    func fetchFavoritePosts() -> Result<[Post], Error> {

        return .success(self.savedPosts)
    }

    func deletePost(_ post: Post) -> Result<Void, Error> {
        
        if let index = savedPosts.firstIndex(where: { $0.id == post.id && $0.userId == post.userId }) {
            self.savedPosts[index].isFavorite = false
        }
        
        return .success(())
    }
}
