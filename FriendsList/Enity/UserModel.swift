//
//  UserModel.swift
//  FriendsList
//
//  Created by christina on 21.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import Foundation

struct UserModel: Decodable {
    let id: Int
    let guid: String
    let isActive: Bool
    let balance: String
    let age: Int
    let eyeColor: String
    let name: String
    let gender: String
    let company: String
    let email: String
    let phone: String
    let address: String
    let about: String
    let registered: String
    let latitude, longitude: Double
    let tags: [String]
    //let friends: [String]
    let friends: [FriendModel]
    let favoriteFruit: String
}

struct FriendModel: Decodable {
    let id: Int
}
