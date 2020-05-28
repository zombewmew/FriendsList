//
//  FriendsListView.swift
//  FriendsList
//
//  Created by christina on 11.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class FriendsListView: UIViewController, UITableViewDelegate {
    
    var safeArea: UILayoutGuide!
    var presenter: ViewToPresenterProtocol?
    let def = UserDefaults.standard
    
    var friendArrayList: Array<UserModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDataTime()
        
        self.view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        self.title = "Friends"
        
        presenter?.startFetching()

        setupTableView()
    }
    
    func checkDataTime() {
        
        let op = def.string(forKey: "opened")
        if op != nil {
            let now = Date()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            if let dateExpired = dateFormatter.date(from: op!) {
                if dateExpired < now {
                    print("update data time expired")
                    def.set(Date().addingTimeInterval(300), forKey: "opened")
                }
            }
            
        } else {
            print("set dite's time expired")
            let date = Date().addingTimeInterval(300)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateString = dateFormatter.string(from: date)
            
            def.set(dateString, forKey: "opened")
        }
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
        
    func setupTableView() {
        view.addSubview(tableView)
        addConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(FriendsListViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}

//MARK: - Protocols extensions

extension FriendsListView: PresenterToViewProtocol {
    func showFriend(friendArray: Array<UserModel>) {
        self.friendArrayList = friendArray
        self.tableView.reloadData()
    }
    
    func showError() {
        print("error")
    }
}

//MARK: - Table View Data Source extension

extension FriendsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsListViewCell
        cell.user = friendArrayList[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if friendArrayList[indexPath.row].isActive {
            presenter?.showUserProfileView(navigationController: navigationController!, user: friendArrayList[indexPath.row])
        }
    }

}

