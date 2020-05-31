//
//  DataManager.swift
//  FriendsList
//
//  Created by christina on 29.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit
import CoreData

class DataManager: UIViewController {
    
    var dataProvider: DataProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let context = dataProvider?.persistentContainer.viewContext else {
            return
        }
    }
}
