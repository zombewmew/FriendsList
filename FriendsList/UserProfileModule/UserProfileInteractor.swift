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
        
        let result = DataManager.decodeСoreData(users: usersResult)
        
        presenter?.friendsFetchSuccess(friendModelArray: result)
        
    }
    
}
