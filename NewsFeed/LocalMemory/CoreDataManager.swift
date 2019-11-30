//
//  CoreDataManager.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager {
    // MARK: - Nested types
    enum Entities: String {
        case article = "ArticleLocal"
    }
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsFeed")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Methods
    func clearData(in entity: Entities) throws {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        try managedObjectContext.execute(deleteRequest)
    }
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
