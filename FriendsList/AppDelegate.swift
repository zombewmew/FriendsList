//
//  AppDelegate.swift
//  FriendsList
//
//  Created by christina on 11.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dataProvider = DataProvider(modelName: "FriendsList")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let friends = FriendsListRouter.createModule()
        friends.dataProvider = dataProvider
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: friends)
        window?.makeKeyAndVisible()
        
        return true
        
    }
}
    
