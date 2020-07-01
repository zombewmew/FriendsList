//
//  FriendsListInteractor.swift
//  FriendsList
//
//  Created by christina on 20.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit
import Alamofire
import CoreData


class FriendsListInteractor: PresenterToInteractorProtocol {
    
    var dataProvider: DataProvider?
    var presenter: InteractorToPresenterProtocol?
    let def = UserDefaults.standard
    
    func fetch() {
        AF.request(API_FRIENDS_LIST, method: .get).responseJSON { response in
            if response.data != nil {
                do {
                    //save to Core Data
                    let decodeData = try JSONDecoder().decode(Array<UserModel>.self, from: response.data!)
                    self.saveData(users: decodeData)
                    
                    //get from Core Data
                    self.getData()
                    
                } catch let error {
                     print(error)
                }
            }
        }
    }
    
    func getData() {
        
        let items = dataProvider!.fetchData(for: User.self)
        let decodedCoreData = DataManager.decodeСoreData(users: items)
        
        self.presenter?.fetchedSuccess(friendModelArray: decodedCoreData)
    }
    
    func saveData(users: [UserModel]) {
        guard let context = dataProvider?.persistentContainer.viewContext else {
            return
        }
        
        dataProvider?.clearContext(context: context)
        
        for user in users {
            let newUser = User(context: context)

            newUser.about = user.about
            newUser.address = user.address
            newUser.age = Int16(user.age)
            newUser.balance = user.balance
            newUser.company = user.company
            newUser.email = user.email
            newUser.eyeColor = user.eyeColor
            newUser.favoriteFruit = user.favoriteFruit
            newUser.gender = user.gender
            newUser.guid = user.guid
            newUser.id = Int16(user.id)
            newUser.isActive = user.isActive
            newUser.latitude = user.latitude
            newUser.longitude = user.longitude
            newUser.name = user.name
            newUser.phone = user.phone
            newUser.registered = user.registered
            newUser.tags = user.tags as NSObject
            for friend in user.friends {
                let newFriend = Friend(context: context)
                newFriend.id = Int16(friend.id)
                newUser.addToFriends(newFriend)
            }
            
            dataProvider?.saveContext(context: context)
        }
    }
    
    func isDataExpired() -> Bool {
        
        let op = def.string(forKey: "dataTime")
        if op != nil {
            let now = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            if let dateExpired = dateFormatter.date(from: op!) {
                if dateExpired < now {
                    print("update data's time")
                    
                    let date = Date().addingTimeInterval(30)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let dateString = dateFormatter.string(from: date)
                    
                    def.set(dateString, forKey: "dataTime")
                    return true
                } else {
                    print("data's time not expired yet")
                    return false
                }
            }
            
            return false
            
        } else {

            print("set data's time expired")
            let date = Date().addingTimeInterval(30)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateString = dateFormatter.string(from: date)
            
            def.set(dateString, forKey: "dataTime")
            
            return true
        }
    }
    
}
