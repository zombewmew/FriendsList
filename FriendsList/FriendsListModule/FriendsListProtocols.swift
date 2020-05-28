//
//  Protocols.swift
//  FriendsList
//
//  Created by christina on 21.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    
    func startFetching()
    func showUserProfileView(navigationController: UINavigationController, user: UserModel)
}

protocol InteractorToPresenterProtocol: class {
    func fetchedSuccess(friendModelArray: Array<UserModel>)
    func fetchFailed()
}

protocol PresenterToViewProtocol: class {
    func showFriend(friendArray: Array<UserModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> FriendsListView
    func pushToUserProfileScreen(navigationConroller: UINavigationController, user: UserModel)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetch()
}
