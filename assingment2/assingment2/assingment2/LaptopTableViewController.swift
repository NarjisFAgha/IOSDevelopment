	//
//  LaptopTableViewController.swift
//  assingment2
//
//  Created by user228293 on 6/23/24.
//

import UIKit

class LaptopTableViewController: UITableViewController {

    // Array used to store laptop details
        var laptops: [(name: String, price: String, additionalInfo: String)] = [
            ("MacBook Pro","16GB RAM", "$1299"),
            ("Dell XP", "512GB SSD", "$999"),
            ("Acer", "64GB", "$1099"),
            ("HP Spectre", "Touchscreen", "$1099"),
            ("Dell Inspiron 15", "128GB SSD", "$1299"),
            ("MacBook M1", "512GB", "$1599"),
            ("IBM Tablet","8996799", "$999")
        ]

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Laptops"
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "laptopCell")
            setupNavigationBar()
        }

        // Navigation Bar to close the page and add item
        func setupNavigationBar() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLaptop))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeView))
        }

        // function to add a new laptop to the list
        @objc func addLaptop() {
            let newLaptop = ("Samsung", "256GB SSD", "$899")
            laptops.append(newLaptop)
            tableView.reloadData()
        }

        // Close the laptop table view
        @objc func closeView() {
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }

        // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return laptops.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "laptopCell", for: indexPath)
            let laptop = laptops[indexPath.row]
            cell.textLabel?.text = "\(laptop.name) - \(laptop.price) - \(laptop.additionalInfo)"
            return cell
        }

        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                laptops.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

       override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
           let movedLaptop = laptops.remove(at: fromIndexPath.row)
           laptops.insert(movedLaptop, at: to.row)
       }

       override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           return true
           
       }

        

}
