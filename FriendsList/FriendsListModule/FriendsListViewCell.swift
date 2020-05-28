//
//  FriendsListViewCell.swift
//  FriendsList
//
//  Created by christina on 22.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class FriendsListViewCell: UITableViewCell {
    
    var user: UserModel? {
        didSet {
            infoButton.isEnabled = user!.isActive
            friendNameLabel.text = user?.name
            friendEmailLabel.text = user?.email
        }
    }
    
    private lazy var friendNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var friendEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setImage(UIImage(named: "info.circle"), for: .normal)
        button.setImage(UIImage(named: "info.circle.disabled"), for: .disabled)
        button.tintColor = .blue
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(friendNameLabel)
        addSubview(friendEmailLabel)
        addSubview(infoButton)
        addConstraints()
    }

    func addConstraints() {
        NSLayoutConstraint.activate(cellConstraints)
    }
    
    lazy var cellConstraints: [NSLayoutConstraint] = [
        
        friendNameLabel.rightAnchor.constraint(equalTo: infoButton.leftAnchor, constant: -16),
        friendNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        friendNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
        
        friendEmailLabel.rightAnchor.constraint(equalTo: infoButton.leftAnchor, constant: -16),
        friendEmailLabel.topAnchor.constraint(equalTo: friendNameLabel.bottomAnchor, constant: 8),
        friendEmailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        friendEmailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
        
        infoButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        infoButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        infoButton.heightAnchor.constraint(equalToConstant: 32),
        infoButton.widthAnchor.constraint(equalTo: infoButton.heightAnchor, multiplier: 1/1)
    ]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
