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
    
    var dataProvider: DataProvider?
    
    func startFetching() {
        interactor?.dataProvider = dataProvider
        interactor?.fetch()
    }
    
    func getCoreData() {
        interactor?.dataProvider = dataProvider
        interactor?.getData()
    }
    
    func isDataTimeExpired() -> Bool? {
        return interactor?.isDataExpired()
    }
    
    func showUserProfileView(navigationController: UINavigationController, user: UserModel) {
        router?.dataProvider = dataProvider
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

