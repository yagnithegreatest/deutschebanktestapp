//
//  MockCoreDataManager.swift
//  DeutscheBankTestAppTests
//
//  Created by Vladislav Nikolsky on 01.07.2023.
//

@testable import DeutscheBankTestApp
import Foundation
import CoreData

final class MockCoreDataManager: CoreDataManagerProtocol {
    
    var container: NSPersistentContainer
    var isSaveCalled = false
    var isFetchCalled = false
    var isDeleteCalled = false
    
    init() {
        self.container = NSPersistentContainer(name: "TestContainer")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        self.container.persistentStoreDescriptions = [description]
        self.container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func save<T: NSManagedObject>(object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        isSaveCalled = true
        completion(.success(()))
    }
    
    func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil) -> Result<[T], Error> {
        isFetchCalled = true
        return .success([])
    }
    
    func delete<T: NSManagedObject>(type: T.Type, predicate: NSPredicate, completion: @escaping (Result<Void, Error>) -> Void) {
        isDeleteCalled = true
        completion(.success(()))
    }
}
