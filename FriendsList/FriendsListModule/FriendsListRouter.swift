//
//  FriendsRouter.swift
//  FriendsList
//
//  Created by christina on 21.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class FriendsListRouter: PresenterToRouterProtocol {
    
    var dataProvider: DataProvider?
    
    //let dataProvider = DataProvider(modelName: "FriendsList")
    
    static func createModule() -> FriendsListView {
        
        let view = FriendsListView()
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = FriendsListPresenter()
        let interactor: PresenterToInteractorProtocol = FriendsListInteractor()
        let router: PresenterToRouterProtocol = FriendsListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    func pushToUserProfileScreen(navigationConroller navigationController: UINavigationController, user: UserModel) {
        
        //let dataProvider: DataProvider?

        let userModule = UserProfileRouter.createModule(data: user)
        userModule.dataProvider = dataProvider
        
        navigationController.pushViewController(userModule, animated: true)
        
    }
    
}
