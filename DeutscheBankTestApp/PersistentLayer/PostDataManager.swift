//
//  CoreDataPostManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import CoreData

protocol PostDataManagerProtocol {
    
    func isPostFavorited(id: Int, userID: Int) -> Result<Bool, Error>
    
    func savePost(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void)
    
    func fetchFavoritePosts() -> Result<[Post], Error>
    
    func deletePost(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void)
}

final class PostDataManager: PostDataManagerProtocol {
    
    // MARK: - Private properties
    private let coreDataManager: CoreDataManagerProtocol

    // MARK: - Init
    init(manager: CoreDataManagerProtocol = ServiceLocator.shared.getService()) {
        self.coreDataManager = manager
    }

    // MARK: - API
    func isPostFavorited(id: Int, userID: Int) -> Result<Bool, Error> {
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "postId == %d", id),
            NSPredicate(format: "userId == %d", userID)
        ])

        return self.coreDataManager.fetch(type: PostEntity.self,
                                          predicate: predicate).map { !$0.isEmpty }
    }

    func savePost(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let postEntity = PostEntity(context: coreDataManager.container.viewContext)
        postEntity.postId = Int32(post.id)
        postEntity.userId = Int32(post.userId)
        postEntity.title = post.title
        postEntity.body = post.body
        
        self.coreDataManager.save(object: postEntity, completion: completion)
    }

    func fetchFavoritePosts() -> Result<[Post], Error> {
        
        return self.coreDataManager.fetch(type: PostEntity.self, predicate: nil).map { entities in
            entities.map { Post(userId: Int($0.userId), id: Int($0.postId), title: $0.title ?? "", body: $0.body ?? "", isFavorite: true) }
        }
    }
    
    func deletePost(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let predicate = NSPredicate(format: "postId == %d AND userId == %d", post.id, post.userId)

        self.coreDataManager.delete(type: PostEntity.self, predicate: predicate, completion: completion)
    }
}
