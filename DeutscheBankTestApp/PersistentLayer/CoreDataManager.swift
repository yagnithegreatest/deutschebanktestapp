//
//  CoreDataManager.swift
//  DeutscheBankTestApp
//
//  Created by Vladislav Nikolsky on 30.06.2023.
//

import CoreData
import Foundation

final class CoreDataManager<Entity: NSManagedObject>: ObservableObject {
    
    let container: NSPersistentContainer

    init() {
        
        self.container = NSPersistentContainer(name: "DeutscheBankTestApp")
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }

    func saveEntity(entity: Entity, completion: @escaping (Bool) -> Void) {
        
        do {
            try self.container.viewContext.save()
            completion(true)
        } catch let error {
            print("Core Data save failed: \(error)")
            completion(false)
        }
    }

    func fetchEntities(completion: @escaping ([Entity]) -> Void){
        
        let fetchRequest = NSFetchRequest<Entity>(entityName: String(describing: Entity.self))
        do {
            let entities = try self.container.viewContext.fetch(fetchRequest)
            completion(entities)
        } catch let error {
            print("Core Data fetch failed: \(error)")
            completion([])
        }
    }

    func deleteEntity(matching predicate: NSPredicate, completion: @escaping (Bool) -> Void) {
        
        let fetchRequest = NSFetchRequest<Entity>(entityName: String(describing: Entity.self))
        fetchRequest.predicate = predicate
        
        do {
            let entities = try self.container.viewContext.fetch(fetchRequest)
            for entity in entities {
                self.container.viewContext.delete(entity)
            }
            
            try self.container.viewContext.save()
            completion(true)
        } catch let error {
            print("Core Data delete failed: \(error)")
            completion(false)
        }
    }
}
