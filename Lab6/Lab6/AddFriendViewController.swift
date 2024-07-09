//
//  AddFriendViewController.swift
//  Lab6
//
//  Created by user228293 on 7/8/24.
//

import UIKit

protocol AddFriendDelegate: AnyObject {
    func didAddFriend(friend: [String: String])
}

class AddFriendViewController: UIViewController {
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var phonetext: UITextField!
    @IBOutlet weak var FirstNameText: UITextField!
    weak var delegate: AddFriendDelegate?

       override func viewDidLoad() {
           super.viewDidLoad()
       }

    
    @IBAction func clearButtonTapped(_ sender: Any) {
        FirstNameText.text = ""
        emailtext.text = ""
        phonetext.text = ""
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = FirstNameText.text, !name.isEmpty,
                      let phone = phonetext.text, !phone.isEmpty,
                      let email = emailtext.text, !email.isEmpty else {
                    showAlert(title: "Important", message: "Please Enter all the feilds")
                    return
    }
        let friend = ["name": name, "phone": phone, "email": email]
               delegate?.didAddFriend(friend: friend)
               showAlert(title: "Done", message: "Added") {
                   self.navigationController?.popViewController(animated: true)
               }
           }
           
           private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
               let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                   completion?()
               })
               present(alertController, animated: true, completion: nil)
           }
       }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


