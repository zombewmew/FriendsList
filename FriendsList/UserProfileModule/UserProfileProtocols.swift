//
//  UserProfileProtocols.swift
//  FriendsList
//
//  Created by christina on 21.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

protocol ViewToPresenterUserProfileProtocol: class {
    var view: PresenterToViewUserProfileProtocol? { get set }
    var interactor: PresenterToInteractorUserProfileProtocol? { get set }
    var router: PresenterToRouterUserProfileProtocol? { get set }
    var dataProvider: DataProvider? { get set }
    
    func startFetchingFriendsById(idArray: [FriendModel])
    func showUserProfileView(navigationController: UINavigationController, user: UserModel)
}

protocol PresenterToViewUserProfileProtocol: class {
    func showFriends(friendArray: Array<UserModel>)
    func showError(error: String)
}

protocol PresenterToRouterUserProfileProtocol: class {
    var dataProvider: DataProvider? { get set }
    static func createModule(data: UserModel) -> UserProfileView
    func pushToUserProfileScreen(navigationConroller: UINavigationController, user: UserModel)
}

protocol PresenterToInteractorUserProfileProtocol: class {
    var dataProvider: DataProvider? { get set }
    var presenter: InteractorToPresenterUserProfileProtocol? { get set }
    
    func fetchUsers(friendsId: [FriendModel])
}

protocol InteractorToPresenterUserProfileProtocol: class {
    func friendsFetchSuccess(friendModelArray: Array<UserModel>)
    func friendsFetchFailed(error: String)
    
}
