//
//  UserProfileInteractor.swift
//  FriendsList
//
//  Created by christina on 20.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import Foundation
import CoreData

class UserProfileInteractor: PresenterToInteractorUserProfileProtocol {
    var dataProvider: DataProvider?
    
    var presenter: InteractorToPresenterUserProfileProtocol?
    
    var items = [User]()
    var usersResult: [User] = []
    
    func fetchUsers(friendsId: [FriendModel]) {
        
        items = dataProvider!.fetchData(for: User.self)
        
        for item in items {
            for friend in friendsId {
                if item.id == friend.id {
                    usersResult.append(item)
                }
            }
        }
        
        let result = convertToUserModel(users: usersResult)
        
        presenter?.friendsFetchSuccess(friendModelArray: result)
        
    }
    
    func convertToUserModel(users: [User]) -> [UserModel] {
        var convertedArray: [UserModel] = []
    
        for user in users {
            let about = user.about!
            let address = user.address!
            let age = Int(user.age)
            let balance = user.balance!
            let company = user.company!
            let email = user.email!
            let eyeColor = user.eyeColor!
            let favoriteFruit = user.favoriteFruit!
            let gender = user.gender!
            let guid = user.guid!
            let id = Int(user.id)
            let isActive = user.isActive
            let latitude = user.latitude
            let longitude = user.longitude
            let name = user.name!
            let phone = user.phone!
            let registered = user.registered!
            let tags = user.tags as! [String]
            
            let friendsArr = user.friends!.allObjects as! [Friend]
            var friends: [FriendModel] = []
            
            for friend in friendsArr {
                let newFriend = FriendModel(id: Int(friend.id))
                friends.append(newFriend)
            }
            
            let userModel = UserModel(id: id, guid: guid, isActive: isActive, balance: balance, age: age, eyeColor: eyeColor, name: name, gender: gender, company: company, email: email, phone: phone, address: address, about: about, registered: registered, latitude: latitude, longitude: longitude, tags: tags, friends: friends, favoriteFruit: favoriteFruit)
            
            
             convertedArray.append(userModel)
        }
        
        return convertedArray
    }
    

    
    
}
