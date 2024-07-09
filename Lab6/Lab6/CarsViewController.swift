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
        Car(image: UIImage(named: "defaultcar")!, make: "Toyota", model: "Corolla"),
        Car(image: UIImage(named: "defaultcar")!, make: "Honda", model: "Civic"),
        Car(image: UIImage(named: "defaultcar")!, make: "Suzuki", model: "Maruti"),
        Car(image: UIImage(named: "defaultcar")!, make: "Tata", model: "Nano"),
        Car(image: UIImage(named: "defaultcar")!, make: "Suzuki", model: "Swift"),
        Car(image: UIImage(named: "defaultcar")!, make: "Tata", model: "Nexa"),
        Car(image: UIImage(named: "defaultcar")!, make: "Mahindra", model: "Bulero"),
        Car(image: UIImage(named: "defaultcar")!, make: "Mahindra", model: "Thar")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cars"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCar))
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc func addCar() {
        let alert = UIAlertController(title: "Add New Car", message: "Enter car details", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Make"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Model"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let make = alert.textFields?[0].text, !make.isEmpty,
                  let model = alert.textFields?[1].text, !model.isEmpty else {
                
                return
            }
            
            let newCar = Car(image: UIImage(named: "defaultcar")!, make: make, model: model)
            self.cars.append(newCar)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let car = cars[indexPath.row]
        cell.imageView?.image = car.image
        cell.textLabel?.text = car.make
        cell.detailTextLabel?.text = car.model
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

