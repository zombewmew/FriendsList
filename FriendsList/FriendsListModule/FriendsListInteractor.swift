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
    
}
