//
//  CarsTableTableViewController.swift
//  Lab6
//
//  Created by user228293 on 7/8/24.
//

import UIKit

class Car {
    var image: UIImage
    var make: String
    var model: String
    
    init(image: UIImage, make: String, model: String) {
        self.image = image
        self.make = make
        self.model = model
    }
}

class CarsViewController: UITableViewController {
    var cars = [
        Car(image: UIImage(named: "car1")!, make: "Toyota", model: "Corolla"),
        Car(image: UIImage(named: "car2")!, make: "Honda", model: "Civic"),
        // Add more sample cars
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cars"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CarCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCar))
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc func addCar() {
        let newCar = Car(image: UIImage(named: "defaultCar")!, make: "New Make", model: "New Model")
        cars.append(newCar)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath)
        let car = cars[indexPath.row]
        cell.imageView?.image = car.image
        cell.textLabel?.text = "\(car.make) \(car.model)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCar = cars.remove(at: sourceIndexPath.row)
        cars.insert(movedCar, at: destinationIndexPath.row)
    }
}

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
