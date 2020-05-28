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
    func startFetchingMovie()
    func goToEmail(email: String)
}

protocol PresenterToViewUserProfileProtocol: class {
    func onMovieResponseSuccess(movieModelArrayList:Array<UserModel>)
    func onMovieResponseFailed(error: String)
}

protocol PresenterToRouterUserProfileProtocol: class {
    static func createModule(data: UserModel)-> UserProfileView
}

protocol PresenterToInteractorUserProfileProtocol: class {
    var presenter:InteractorToPresenterUserProfileProtocol? { get set }
    func fetch()
}

protocol InteractorToPresenterUserProfileProtocol: class {
    func movieFetchSuccess(movieList: Array<UserModel>)
    func movieFetchFailed()
}
