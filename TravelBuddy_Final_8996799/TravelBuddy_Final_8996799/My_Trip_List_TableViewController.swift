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

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchTrips() // Refresh the data when the view appears
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
           let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
           let trip = trips[indexPath.row]

           cell.tripNameLabel.text = trip.tripName
           cell.destinationLabel.text = trip.destination

           return cell
       }

       // MARK: - Editing and Deleting

       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               let tripToDelete = trips[indexPath.row]
               
               // Show an alert to confirm deletion
               let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip?", preferredStyle: .alert)
               
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                   // Delete the trip from Core Data
                   self.context.delete(tripToDelete)
                   
                   do {
                       try self.context.save()
                       self.trips.remove(at: indexPath.row)
                       tableView.deleteRows(at: [indexPath], with: .fade)
                   } catch {
                       print("Failed to delete trip: \(error)")
                   }
               }))
               
               present(alert, animated: true, completion: nil)
           }
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
