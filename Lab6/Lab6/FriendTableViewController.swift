import UIKit

class FriendTableViewController: UITableViewController {
    var friends: [[String: String]] = [["name": "Narjis", "phone": "7894561230", "email":"narjis@yahoo.com"],
                                       ["name": "Rabab", "phone": "1234567895", "email":"rabab@gmail.com"],
                                       ["name": "Bilal", "phone": "7531264890", "email":"bilal@yahoo.com"],
                                       ["name": "Arun", "phone": "99638527414", "email":"arun@gmail.com"],
                                       ["name": "Jhon", "phone": "5689741235", "email":"jhon@gmail.com"],
                                       ["name": "Jacob", "phone": "8855227744", "email":"jacob@rediff.com"],
                                       ["name": "Tina", "phone": "2255889966", "email":"tina@hotmail.com"],
                                       ["name": "Pooja", "phone": "1144552288", "email":"pooja@gmail.com"]]

       override func viewDidLoad() {
           super.viewDidLoad()
           self.title = "Friends"

           loadFriends()
           
           self.navigationItem.leftBarButtonItem = self.editButtonItem
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
           cell.nameLabel.text = friend["name"]
           cell.phoneLabel.text = friend["phone"]
           cell.emailLabel.text = friend["email"]
           
           cell.cityImageView.image = UIImage(named: "cityimage")
           cell.sportsImageView.image = UIImage(named: "sportsimage")
           cell.foodImageView.image = UIImage(named: "foodimage")

                   return cell
               }

               override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                   if editingStyle == .delete {
                       friends.remove(at: indexPath.row)
                       saveFriends()
                       tableView.deleteRows(at: [indexPath], with: .fade)
                   }
               }

               override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
                   let movedFriend = friends.remove(at: fromIndexPath.row)
                   friends.insert(movedFriend, at: to.row)
                   saveFriends()
               }

               override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                   if segue.identifier == "showAddFriend" {
                   let addFriendVC = segue.destination as! AddFriendViewController
                       addFriendVC.delegate = self
                   }
               }

               func saveFriends() {
                   UserDefaults.standard.set(friends, forKey: "friends")
               }

    func loadFriends() {
            if let savedFriends = UserDefaults.standard.array(forKey: "friends") as? [[String: String]] {
                friends = savedFriends
            }
        }
    }

    extension FriendTableViewController: AddFriendDelegate {
        func didAddFriend(friend: [String: String]) {
            friends.append(friend)
            saveFriends()
            tableView.reloadData()
    }
    }
