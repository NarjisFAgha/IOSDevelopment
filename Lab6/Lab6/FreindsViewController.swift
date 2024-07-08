////
////  FreindsViewController.swift
////  Lab6
////
////  Created by user228293 on 7/8/24.
////
//
//import UIKit
//
//class Friend {
//    var firstName: String
//    var email: String
//    var phone: String
//    var images: [UIImage?]
//    
//    init(firstName: String, email: String, phone: String, images: [UIImage?]) {
//        self.firstName = firstName
//        self.email = email
//        self.phone = phone
//        self.images = images
//    }
//}
//    
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////
////    func configure(with friend: Friend) {
////        firstNameLabel.text = friend.firstName
////        emailLabel.text = friend.email
////        phoneLabel.text = friend.phone
////
////        imagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
////        for image in friend.images {
////            let imageView = UIImageView(image: image)
////            imagesStackView.addArrangedSubview(imageView)
////        }
////    }
////}
//
//class FriendsViewController: UITableViewController {
//    var friends = [
//        Friend(firstName: "John", email: "john@example.com", phone: "123-456-7890", images: [UIImage(named: "img1"), UIImage(named: "img2"), UIImage(named: "img3")]),
//        // Add more sample friends
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Friends"
//        self.tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
//        navigationItem.leftBarButtonItem = editButtonItem
//    }
//    
//    @objc func addFriend() {
//        // Implementation for adding new friend with an alert
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return friends.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
//        let friend = friends[indexPath.row]
//        cell.configure(with: friend)
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            friends.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedFriend = friends.remove(at: sourceIndexPath.row)
//        friends.insert(movedFriend, at: destinationIndexPath.row)
//    }
//}
//
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
