//
//  CoreDataManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import CoreData
import Foundation

protocol CoreDataManagerProtocol {
    
    var container: NSPersistentContainer { get }
    
    func save<T: NSManagedObject>(object: T, completion: @escaping (Result<Void, Error>) -> Void)
    func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate?) -> Result<[T], Error>
    func delete<T: NSManagedObject>(type: T.Type, predicate: NSPredicate, completion: @escaping (Result<Void, Error>) -> Void)
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    // MARK: - Public properties
    let container: NSPersistentContainer
    
    // MARK: - Init
    init() {
        
        self.container = NSPersistentContainer(name: "DeutscheBankTestApp")
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }
    
    // MARK: - API
    func save<T: NSManagedObject>(object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try self.container.viewContext.save()
            completion(.success(()))
        } catch let error {
            print("Core Data save failed: \(error)")
            completion(.failure(error))
        }
    }
    
    func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil) -> Result<[T], Error> {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        
        do {
            let entities = try self.container.viewContext.fetch(fetchRequest)
            return .success(entities)
        } catch let error {
            print("Core Data fetch failed: \(error)")
            return .failure(error)
        }
    }
    
    func delete<T: NSManagedObject>(type: T.Type, predicate: NSPredicate, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        
        do {
            let entities = try self.container.viewContext.fetch(fetchRequest)
            entities.forEach { self.container.viewContext.delete($0) }
            
            try self.container.viewContext.save()
            completion(.success(()))
        } catch let error {
            print("Core Data delete failed: \(error)")
            completion(.failure(error))
        }
    }
}
