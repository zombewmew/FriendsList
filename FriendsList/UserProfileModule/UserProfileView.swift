//
//  UserProfileView.swift
//  FriendsList
//
//  Created by christina on 21.05.2020.
//  Copyright © 2020 zombewnew. All rights reserved.
//

import UIKit
import MapKit

class UserProfileView: UIViewController {
    
    var safeArea: UILayoutGuide!
    var presenter: ViewToPresenterUserProfileProtocol?
    var tags: [String] = []
    var dataProvider: DataProvider?
    var friends: [UserModel] = []
    var friendsId: [FriendModel] = []
    
    var userData: UserModel? {
        didSet {

            nameLabel.text = userData?.name
            ageLabel.text = "\(userData!.age) years"
            companyLabel.text = userData?.company
            adressLabel.text = userData?.address
            aboutLabel.text = userData?.about
            
            phoneButton.setTitle(userData?.phone, for: .normal)
            phoneButton.addTarget(self, action: #selector(goToCall), for: .touchUpInside)
            
            emailButton.setTitle(userData?.email, for: .normal)
            emailButton.addTarget(self, action: #selector(goToEmail), for: .touchUpInside)
            
            balanceLabel.text = editBalance(balance: userData!.balance)

            eyeView.backgroundColor = returnColor(color: userData!.eyeColor)
            
            fruitLabel.text = returnEmoji(fruit: userData!.favoriteFruit)
            
            dataLabel.text = dataFormatter(date: userData!.registered)
            
            coordinatesButton.setTitle("\(userData!.latitude) \(userData!.longitude) ", for: .normal)
            coordinatesButton.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
            
            tags = userData!.tags.map { "#" + $0 }
            tagCollection.reloadData()
            
            friendsId = userData!.friends
            friendsTable.reloadData()
            
        }
    }
    
//MARK: - Data's function
    
    @objc func goToEmail(sender: UIButton) {
        guard let email = sender.titleLabel?.text! else { return }
        
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    @objc func goToCall(sender: UIButton) {
        guard var phone = sender.titleLabel?.text! else { return }
        
        phone = phone.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(phone)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func goToMap(sender: UIButton) {
        guard let coordinatesLabel = sender.titleLabel?.text! else { return }

        let coorArray = coordinatesLabel.components(separatedBy: " ")
        let lat: NSString = coorArray[0] as NSString
        let lng: NSString = coorArray[1] as NSString

        let latitude: CLLocationDegrees =  lat.doubleValue
        let longitude: CLLocationDegrees =  lng.doubleValue

        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
    }

    
    func editBalance(balance: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        var price = balance.replacingOccurrences(of: ",", with: "")
        price = String(price.dropFirst())
        let priceFloat = (price as NSString).floatValue
        let result = "$" + numberFormatter.string(from: NSNumber(value: priceFloat))!

        return result
    }
    
    func returnColor(color: String) -> UIColor {
        switch color {
        case "brown":
            return .brown
        case "blue":
            return .blue
        case "green":
            return .green
        default:
            return .white
        }
    }
    
    func returnEmoji(fruit: String) -> String {
        switch fruit {
        case "banana":
            return "🍌"
        case "apple":
            return "🍏"
        case "strawberry":
            return "🍓"
        default:
            return "🍋"
        }
    }
    
    func dataFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateDecode = dateFormatter.date(from: date)!
        
        dateFormatter.dateFormat = "HH:mm dd.MM.yy"
        let dateResult = dateFormatter.string(from: dateDecode)

        return dateResult
    }
    
//MARK: - Programmatically interface's elements
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var eyeView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fruitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coordinatesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var horizontalScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tagCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var friendsTable: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.backgroundColor = .white
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    

//MARK: - Load ans Setup view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = userData?.name
        safeArea = view.layoutMarginsGuide
        
        presenter?.dataProvider = dataProvider
        presenter?.startFetchingFriendsById(idArray: friendsId)
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailButton)
        contentView.addSubview(ageLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(phoneButton)
        contentView.addSubview(adressLabel)
        contentView.addSubview(aboutLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(eyeView)
        contentView.addSubview(fruitLabel)
        contentView.addSubview(dataLabel)
        contentView.addSubview(coordinatesButton)
        contentView.addSubview(horizontalScrollView)
        horizontalScrollView.addSubview(tagCollection)
        contentView.addSubview(friendsTable)
        
        friendsTable.delegate = self
        friendsTable.dataSource = self
        friendsTable.register(FriendsListViewCell.self, forCellReuseIdentifier: "cell")
        
        addConstraints()
    }

    func addConstraints() {
        NSLayoutConstraint.activate(userProfileConstraints)
    }
    
    lazy var userProfileConstraints: [NSLayoutConstraint] = [
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        
        emailButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
        emailButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        
        ageLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
        ageLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 16),
        
        phoneButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 8),
        phoneButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        
        companyLabel.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 8),
        companyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        
        adressLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 8),
        adressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        adressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),

        aboutLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 8),
        aboutLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        aboutLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        
        balanceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
        balanceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        
        eyeView.heightAnchor.constraint(equalToConstant: 16),
        eyeView.widthAnchor.constraint(equalTo: eyeView.heightAnchor, multiplier: 1/1),
        eyeView.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor),
        eyeView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        
        fruitLabel.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor),
        fruitLabel.rightAnchor.constraint(equalTo: eyeView.leftAnchor, constant: -8),
        
        dataLabel.centerYAnchor.constraint(equalTo: phoneButton.centerYAnchor),
        dataLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        
        coordinatesButton.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
        coordinatesButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        
        horizontalScrollView.heightAnchor.constraint(equalToConstant: 40),
        horizontalScrollView.topAnchor.constraint(equalTo: coordinatesButton.bottomAnchor, constant: 8),
        horizontalScrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        horizontalScrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        
        tagCollection.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor),
        tagCollection.widthAnchor.constraint(equalTo: horizontalScrollView.widthAnchor),
        tagCollection.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor, constant: 0),
        tagCollection.leftAnchor.constraint(equalTo: horizontalScrollView.leftAnchor, constant: 0),
        
        friendsTable.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 8),
        friendsTable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        friendsTable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        friendsTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        
    ]
}


//MARK: - Protocols extensions

extension UserProfileView: PresenterToViewUserProfileProtocol {
    func showFriends(friendArray: Array<UserModel>) {
        print(friendArray)
        self.friends = friendArray
        self.friendsTable.reloadData()
    }
    
    func showError(error: String) {
        print("Error: \(error)")
    }
}

extension UserProfileView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsListViewCell
        cell.user = friends[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if friends[indexPath.row].isActive {
            presenter?.showUserProfileView(navigationController: navigationController!, user: friends[indexPath.row])
        }
    }
    
}

extension UserProfileView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TagCell
        cell.tagString = tags[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 100, height: 25)
    }
    
}
