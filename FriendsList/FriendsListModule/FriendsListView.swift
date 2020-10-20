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
    var dataProvider: DataProvider?
    let def = UserDefaults.standard
    
    var friendArrayList: Array<UserModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        self.title = "Friends"
        
        presenter?.dataProvider = dataProvider
        
        if (presenter?.isDataTimeExpired())! {
            presenter?.startFetching()
        } else {
            presenter?.getCoreData()
        }
        
        setupTableView()
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        NSLayoutConstraint.activate(friendsListConstraints)
    }
    
    lazy var friendsListConstraints: [NSLayoutConstraint] = [
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
    ]

}

//MARK: - Protocols extensions

extension FriendsListView: PresenterToViewProtocol {
    func showFriend(friendArray: Array<UserModel>) {
        self.friendArrayList = friendArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if friendArrayList[indexPath.row].isActive {
            presenter?.showUserProfileView(navigationController: navigationController!, user: friendArrayList[indexPath.row])
        }
    }

}


