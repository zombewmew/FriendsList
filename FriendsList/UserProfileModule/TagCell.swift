//
//  TagCell.swift
//  FriendsList
//
//  Created by christina on 25.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    var tagString: String? {
        didSet {
            tagLabel.text = tagString!
        }
    }
    
   fileprivate var tagLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = .blue
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tagLabel)
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate(tagConstraints)
    }

    lazy var tagConstraints: [NSLayoutConstraint] = [
        tagLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        tagLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
        tagLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
    ]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
