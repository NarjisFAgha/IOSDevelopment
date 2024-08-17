//
//  My_Trip_List_TableViewController.swift
//  TravelBuddy_Final_8996799
//
//  Created by user228293 on 8/17/24.
//

import UIKit
import CoreData

class My_Trip_List_TableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var trips: [Trip] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrips()
    }

    // MARK: - Core Data Fetch

    func fetchTrips() {
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Failed to fetch trips: \(error)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)
        let trip = trips[indexPath.row]

        // Configure the cell
        cell.textLabel?.text = trip.tripName
        cell.detailTextLabel?.text = trip.destination

        return cell
    }

    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrip = trips[indexPath.row]
        performSegue(withIdentifier: "showTripDetail", sender: selectedTrip)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTripDetail" {
            if let destinationVC = segue.destination as? TripDetailViewController,
               let selectedTrip = sender as? Trip {
                destinationVC.trip = selectedTrip
            }
        }
    }
}
