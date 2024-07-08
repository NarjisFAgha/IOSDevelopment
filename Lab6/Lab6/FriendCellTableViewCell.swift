////
////  FriendCellTableViewCell.swift
////  Lab6
////
////  Created by user228293 on 7/8/24.
////
//
//import UIKit
//
//class FriendCellTableViewCell: UITableViewCell {
//    var firstNameLabel: UILabel!
//    var emailLabel: UILabel!
//    var phoneLabel: UILabel!
//    var imagesStackView: UIStackView!
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        firstNameLabel = UILabel()
//        emailLabel = UILabel()
//        phoneLabel = UILabel()
//        
//        imagesStackView = UIStackView()
//        imagesStackView.axis = .horizontal
//        imagesStackView.distribution = .fillEqually
//        imagesStackView.spacing = 5
//        
//        let stackView = UIStackView(arrangedSubviews: [firstNameLabel, emailLabel, phoneLabel, imagesStackView])
//        stackView.axis = .vertical
//        stackView.spacing = 10
//        
//        contentView.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(with friend: Friend) {
//        firstNameLabel.text = friend.firstName
//        emailLabel.text = friend.email
//        phoneLabel.text = friend.phone
//        
//        imagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//        for image in friend.images {
//            let imageView = UIImageView(image: image)
//            imagesStackView.addArrangedSubview(imageView)
//        }
//    }
//}
