//
//  FriendTableViewController.swift
//  Lab6
//
//  Created by user228293 on 7/8/24.
//

import UIKit

class Friend {
    var name: String
    var email: String
    var phone: String
    var foodImage: UIImage
    var sportsImage: UIImage
    var cityImage: UIImage
    
    init(name: String, email: String, phone: String, foodImage: UIImage, sportsImage: UIImage, cityImage: UIImage) {
        self.name = name
        self.email = email
        self.phone = phone
        self.foodImage = foodImage
        self.sportsImage = sportsImage
        self.cityImage = cityImage
    }
}

class FriendTableViewController: UITableViewController {
    var friends: [Friend] = []

    @IBAction func addbutton(_ sender: Any) {
        performSegue(withIdentifier: "showAddFriend", sender: self)
    }
    @IBOutlet weak var foodimage: UIImageView!
    @IBOutlet weak var sportsimage: UIImageView!
    @IBOutlet weak var cityimage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
               tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
               navigationItem.rightBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return friends.count
      }

      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
          let friend = friends[indexPath.row]
          cell.nameLabel.text = friend.name
          cell.emailLabel.text = friend.email
          cell.phoneLabel.text = friend.phone
          cell.foodImageView.image = friend.foodImage
          cell.sportsImageView.image = friend.sportsImage
          cell.cityImageView.image = friend.cityImage
          return cell
      }

      override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              friends.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
          }
      }

      override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
          let movedFriend = friends.remove(at: sourceIndexPath.row)
          friends.insert(movedFriend, at: destinationIndexPath.row)
      }

      // Prepare for segue to add friend
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "showAddFriend" {
              if let destinationVC = segue.destination as? AddFriendViewController {
                  destinationVC.delegate = self
              }
          }
      }
  }

  extension FriendTableViewController: AddFriendDelegate {
      func didAddFriend(_ friend: Friend) {
          friends.append(friend)
          tableView.reloadData()
      }
  }
