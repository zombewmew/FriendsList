//
//  UserProfileRouter.swift
//  FriendsList
//
//  Created by christina on 21.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class UserProfileRouter: PresenterToRouterUserProfileProtocol {
    
    static func createModule(data: UserModel) -> UserProfileView {
        
        let view = UserProfileView()
        view.userData = data
        
        let presenter: ViewToPresenterUserProfileProtocol & InteractorToPresenterUserProfileProtocol = UserProfilePresenter()
        let interactor: PresenterToInteractorUserProfileProtocol = UserProfileInteractor()
        let router: PresenterToRouterUserProfileProtocol = UserProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
}
