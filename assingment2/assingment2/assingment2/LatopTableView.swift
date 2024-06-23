//
//  LatopTableView.swift
//  assingment2
//
//  Created by user228293 on 6/23/24.
//

import UIKit

private let reuseIdentifier = "Cell"


class LaptopsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var laptops: [(name: String, price: Double, info: String)] = [
        ("MacBook Pro", 2399.00, "16-inch"),
        ("Dell XPS 13", 999.99, "13-inch"),
        ("HP Spectre x360", 1199.99, "13.3-inch")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Laptops"
        
        setupNavigationBar()
        setupTableView()
        insertIBMTablet()
    }
    
    func setupNavigationBar() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLaptop))
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LaptopCell")
        view.addSubview(tableView)
    }
    
    @objc func close() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addLaptop() {
        let newLaptop = ("New Laptop", 1499.99, "15-inch")
        laptops.append(newLaptop)
        tableView.reloadData()
    }
    
    func insertIBMTablet() {
        let studentNumber = "8871471" // Replace with your actual student number
        if let fifthDigit = Int(String(Array(studentNumber)[4])) {
            let ibmTablet = ("IBM Tablet", 999.00, "\(studentNumber)")
            laptops.insert(ibmTablet, at: min(fifthDigit, laptops.count))
        }
    }

    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laptops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaptopCell", for: indexPath)
        let laptop = laptops[indexPath.row]
        cell.textLabel?.text = "\(laptop.name) - $\(laptop.price) - \(laptop.info)"
        return cell
    }
}
