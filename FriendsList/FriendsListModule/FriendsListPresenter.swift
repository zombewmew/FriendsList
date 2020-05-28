//
//  FriendsListPresenter.swift
//  FriendsList
//
//  Created by christina on 20.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class FriendsListPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetching() {
        interactor?.fetch()
    }
    
    func showUserProfileView(navigationController: UINavigationController, user: UserModel) {
        router?.pushToUserProfileScreen(navigationConroller: navigationController, user: user)
    }

}

extension FriendsListPresenter: InteractorToPresenterProtocol{
    func fetchedSuccess(friendModelArray: Array<UserModel>) {
        view?.showFriend(friendArray: friendModelArray)
    }
    
    func fetchFailed() {
        view?.showError()
    }
    
}

