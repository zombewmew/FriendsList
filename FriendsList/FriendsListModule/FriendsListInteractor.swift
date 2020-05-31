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

    var items = [User]()
    
    func fetch() {
        AF.request(API_FRIENDS_LIST, method: .get).responseJSON { response in
            if response.data != nil {
                do {
                    let decodeData = try JSONDecoder().decode(Array<UserModel>.self, from: response.data!)
                    self.saveData(users: decodeData)
                    //self.fetchCoreData()
                    self.presenter?.fetchedSuccess(friendModelArray: decodeData)
                    self.fetchData()
                    //print(self.dataProvider)
                    //self.items = self.dataProvider.fetchData(for: User.self)
                    //print(self.items)
                    
                    
                } catch let error {
                     print(error)
                }
            }
        }
    }
    
    private func fetchData() {
        items = dataProvider!.fetchData(for: User.self)
        print(items[0].friends!.value(forKey: "id"))
    }
    
    func saveData(users: [UserModel]) {
        guard let context = dataProvider?.persistentContainer.viewContext else {
            return
        }
        dataProvider?.clearContext(context: context)
        //DataProvider.clearContext()
        
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
    
    func fetchCoreData() {

        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(value: true)
        request.predicate = predicate
        
        // Create Predicate
        /*var friend: [Friend] = []
        //let predicate = NSPredicate(format: "%K == %@", "last", "Doe")
        let predicate = NSPredicate(format:"friends == %@", friend)
        //let predicate = NSPredicate(format: "%K == %@", #keyPath(User.friends))
        request.predicate = predicate*/
        var query = ""
        do {
            let fetchReq: NSFetchRequest<User> = User.fetchRequest()
            let predicate = NSPredicate(value: true)
            fetchReq.predicate = predicate
            //let users = try DataProvider.context.fetch(fetchReq)
            //print(users)
            
            /*for user in users as! [NSManagedObject] {
                print(user.value(forKey: "friends"))
                 //if query.isEmpty {
                   request.predicate = NSPredicate(format: "owner = %@", user)
                 //} else {
                    //print("else")
                    //request.predicate = NSPredicate(format: "owner = %@", user)
                   //request.predicate = NSPredicate(format: "name CONTAINS[cd] %@ AND owner = %@", query, friend)
                 //}
            }*/
            let request = Friend.fetchRequest() as NSFetchRequest<Friend>
            
            //print(users)
            /*for user in users as! [NSManagedObject] {
                print(user.value(forKey: "friends"))
            }*/
        } catch {
            //interactor?.showError()
        }
        
        //print("mew")
        
        /*do {
            let result = try DataProvider.context.fetch(request)
            print(result)
        } catch  {
            //
        }*/
        
        /*do {
            let result = try DataProvider.context.fetch(request)
            var users: [UserModel] = []
            for user in result as! [NSManagedObject] {
                var friends: [FriendModel] = []
                user.value(forKey: <#T##String#>).
                print(user.value(forKey: "friends"))
                for friend in user.value(forKey: "friends") as! [NSManagedObject] {
                    let fetchedFriend = FriendModel(id: friend.value(forKey: "id") as! Int)
                    print(fetchedFriend)
                    friends.append(fetchedFriend)
                }
                var fetchedUser = UserModel(id: user.value(forKey: "id") as! Int,
                                            guid: user.value(forKey: "guid") as! String,
                                            isActive: user.value(forKey: "isActive") as! Bool,
                                            balance: user.value(forKey: "balance") as! String,
                                            age: user.value(forKey: "age") as! Int,
                                            eyeColor: user.value(forKey: "eyeColor") as! String,
                                            name: user.value(forKey: "name") as! String,
                                            gender: user.value(forKey: "gender") as! String,
                                            company: user.value(forKey: "company") as! String,
                                            email: user.value(forKey: "email") as! String,
                                            phone: user.value(forKey: "phone") as! String,
                                            address: user.value(forKey: "address") as! String,
                                            about: user.value(forKey: "about") as! String,
                                            registered: user.value(forKey: "registered") as! String,
                                            latitude: user.value(forKey: "latitude") as! Double,
                                            longitude: user.value(forKey: "longitude") as! Double,
                                            tags: user.value(forKey: "tags") as! [String],
                                            friends: friends,
                                            favoriteFruit: user.value(forKey: "favoriteFruit") as! String)
                
                users.append(fetchedUser)
                
            }
            print(users)
            
        } catch {
            
            print("Failed")
        }*/
        
    }
    
}
