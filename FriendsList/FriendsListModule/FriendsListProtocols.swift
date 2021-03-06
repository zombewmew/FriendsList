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
    var dataProvider: DataProvider? { get set }
    
    func startFetching()
    func getCoreData()
    func isDataTimeExpired() -> Bool?
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
    var dataProvider: DataProvider? { get set }
    static func createModule() -> FriendsListView
    func pushToUserProfileScreen(navigationConroller: UINavigationController, user: UserModel)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    var dataProvider: DataProvider? { get set }
    func fetch()
    func getData()
    func isDataExpired() -> Bool
}
