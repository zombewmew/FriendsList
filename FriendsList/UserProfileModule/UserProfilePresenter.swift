//
//  UserProfilePresenter.swift
//  FriendsList
//
//  Created by christina on 20.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class UserProfilePresenter: ViewToPresenterUserProfileProtocol {

    var view: PresenterToViewUserProfileProtocol?
    
    var interactor: PresenterToInteractorUserProfileProtocol?
    
    var router: PresenterToRouterUserProfileProtocol?
    
    func startFetchingMovie() {
        print("sdf")
    }
    
    func goToEmail(email: String) {
        print(email)
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    
}

extension UserProfilePresenter: InteractorToPresenterUserProfileProtocol{
    func movieFetchSuccess(movieList: Array<UserModel>) {
        print("")
    }
    
    func movieFetchFailed() {
        print("error")
    }
    

    
}
