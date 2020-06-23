//
//  UserProfilePresenter.swift
//  FriendsList
//
//  Created by christina on 20.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class UserProfilePresenter: ViewToPresenterUserProfileProtocol {
    var dataProvider: DataProvider?

    var view: PresenterToViewUserProfileProtocol?
    
    var interactor: PresenterToInteractorUserProfileProtocol?
    
    var router: PresenterToRouterUserProfileProtocol?
    
    func startFetchingFriendsById(idArray: [FriendModel]) {
        interactor?.dataProvider = dataProvider
        interactor?.fetchUsers(friendsId: idArray)
    }
    
    func showUserProfileView(navigationController: UINavigationController, user: UserModel) {
        router?.dataProvider = dataProvider
        router?.pushToUserProfileScreen(navigationConroller: navigationController, user: user)
    }
}

extension UserProfilePresenter: InteractorToPresenterUserProfileProtocol {
    func friendsFetchSuccess(friendModelArray: Array<UserModel>) {
        view?.showFriends(friendArray: friendModelArray)
    }
    
    func friendsFetchFailed(error: String) {
        view?.showError(error: error)
    }
}
