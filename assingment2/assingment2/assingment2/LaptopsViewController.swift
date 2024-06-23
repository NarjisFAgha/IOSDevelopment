//
//  LaptopsViewController.swift
//  assingment2
//
//  Created by user228293 on 6/23/24.
//

import UIKit


class LaptopsViewController: UITableViewController {

    // Array to store laptop details
      var laptops: [(name: String, price: String, additionalInfo: String)] = [
          ("MacBook Pro", "$1299", "16GB RAM"),
          ("Dell XPS", "$999", "512GB SSD"),
          ("HP Spectre", "$1099", "Touchscreen")
      ]

      override func viewDidLoad() {
          super.viewDidLoad()
          self.title = "Laptops"
          self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "laptopCell")
          setupNavigationBar()
      }

      // Sets up the navigation bar with Add and Close buttons
      func setupNavigationBar() {
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLaptop))
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeView))
      }

      // Adds a new laptop to the list and reloads the table view
      @objc func addLaptop() {
          let newLaptop = ("IBM Tablet", "$999", "Student Number Based")
          laptops.append(newLaptop)
          tableView.reloadData()
      }

      // Closes the current view controller
      @objc func closeView() {
          self.dismiss(animated: true, completion: nil)
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

       // Supports editing the table view (e.g., deleting rows)
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }

       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               laptops.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }

       // Supports rearranging the table view rows
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            let movedLaptop = laptops.remove(at: fromIndexPath.row)
            laptops.insert(movedLaptop, at: to.row)
        }

        override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
            
        }

    }
