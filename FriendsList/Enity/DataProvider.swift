//
//  DataProvider.swift
//  FriendsList
//
//  Created by christina on 26.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

final class DataProvider {

    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //static var context = persistentContainer.viewContext
    //lazy var context = persistentContainer.viewContext
    
    func context() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearContext(context: NSManagedObjectContext) {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteUserRequest = NSBatchDeleteRequest(fetchRequest: fetchUserRequest)
        
        let fetchFriendRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        let deleteFriendRequest = NSBatchDeleteRequest(fetchRequest: fetchFriendRequest)
        
        do {
            try context.execute(deleteUserRequest)
            try context.execute(deleteFriendRequest)
        } catch let error as NSError {
            print("Clear context error \(error)")
        }
    }
    
    
    func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T] {
        let context = getContext()
        // 6
        let request: NSFetchRequest<T>
        var fetchedResult = [T]()
        // 7
        if #available(iOS 10.0, *) {
            request = entity.fetchRequest() as! NSFetchRequest<T>
        } else {
            let entityName = String(describing: entity)
            request = NSFetchRequest(entityName: entityName)
        }
        // 8
        do {
            fetchedResult = try context.fetch(request)
            
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
        }
        
        return fetchedResult
    }
}
