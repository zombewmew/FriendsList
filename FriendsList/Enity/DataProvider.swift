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

class DataProvider {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FriendsList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static var context = persistentContainer.viewContext
    

    // MARK: - Core Data Saving support

    static func saveContext() {
        if DataProvider.context.hasChanges {
            do {
                try DataProvider.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func clearContext() {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteUserRequest = NSBatchDeleteRequest(fetchRequest: fetchUserRequest)
        
        let fetchFriendRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        let deleteFriendRequest = NSBatchDeleteRequest(fetchRequest: fetchFriendRequest)
        
        do {
            try DataProvider.context.execute(deleteUserRequest)
            try DataProvider.context.execute(deleteFriendRequest)
        } catch let error as NSError {
            print("Clear context error \(error)")
        }
    }
    
}
