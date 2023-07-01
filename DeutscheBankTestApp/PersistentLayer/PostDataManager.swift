//
//  CoreDataPostManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import CoreData

protocol PostDataManagerProtocol {
    
    func isPostFavorited(id: Int, userID: Int) -> Result<Bool, Error>
    
    func savePost(_ post: Post) -> Result<Void, Error>
    
    func fetchFavoritePosts() -> Result<[Post], Error>
    
    func deletePost(_ post: Post) -> Result<Void, Error>
}

final class PostDataManager: PostDataManagerProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol

    init(manager: CoreDataManagerProtocol = ServiceLocator.shared.getService()) {
        self.coreDataManager = manager
    }

    func isPostFavorited(id: Int, userID: Int) -> Result<Bool, Error> {
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "postId == %d", id),
            NSPredicate(format: "userId == %d", userID)
        ])

        return self.coreDataManager.fetch(type: PostEntity.self,
                                          predicate: predicate).map { !$0.isEmpty }
    }

    func savePost(_ post: Post) -> Result<Void, Error> {
        
        let postEntity = PostEntity(context: coreDataManager.container.viewContext)
        postEntity.postId = Int32(post.id)
        postEntity.userId = Int32(post.userId)
        postEntity.title = post.title
        postEntity.body = post.body
        
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Void, Error>?
        
        self.coreDataManager.save(object: postEntity) { saveResult in
            result = saveResult
            semaphore.signal()
        }
        
        semaphore.wait()
        return result ?? .failure(NSError(domain: "", code: -1, userInfo: nil))
    }

    func fetchFavoritePosts() -> Result<[Post], Error> {
        
        return self.coreDataManager.fetch(type: PostEntity.self, predicate: nil).map { entities in
            entities.map { Post(userId: Int($0.userId), id: Int($0.postId), title: $0.title ?? "", body: $0.body ?? "", isFavorite: true) }
        }
    }
    
    func deletePost(_ post: Post) -> Result<Void, Error> {
        
        let predicate = NSPredicate(format: "postId == %d AND userId == %d", post.id, post.userId)

        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Void, Error>?
        
        self.coreDataManager.delete(type: PostEntity.self, predicate: predicate) { deleteResult in
            result = deleteResult
            semaphore.signal()
        }
        
        semaphore.wait()
        return result ?? .failure(NSError(domain: "", code: -1, userInfo: nil))
    }
}
