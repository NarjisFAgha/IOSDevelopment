//
//  Add_trip_ViewController.swift
//  TravelBuddy_Final_8996799
//
//  Created by user228293 on 8/17/24.
//

import UIKit
import CoreData

class Add_trip_ViewController: UIViewController {

    @IBOutlet weak var tripNamelabel: UILabel!
    
    @IBOutlet weak var endDateTextfield: UITextField!
    @IBOutlet weak var startDateTextfield: UITextField!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var startLocationTextfield: UITextField!
    @IBOutlet weak var tripNametextfield: UITextField!
    let datePicker = UIDatePicker()

       override func viewDidLoad() {
           super.viewDidLoad()
           
           setupDatePickers()
       }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

       func setupDatePickers() {
           // Set up date pickers for start and end date text fields
           startDateTextfield.inputView = datePicker
           endDateTextfield.inputView = datePicker
           
           datePicker.datePickerMode = .date
           datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
       }

       @objc func dateChanged(datePicker: UIDatePicker) {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .none
           
           if startDateTextfield.isFirstResponder {
               startDateTextfield.text = formatter.string(from: datePicker.date)
           } else if endDateTextfield.isFirstResponder {
               endDateTextfield.text = formatter.string(from: datePicker.date)
           }
       }

    @IBAction func clearButton(_ sender: Any) {
        // Clear all text fields
                tripNametextfield.text = ""
                startLocationTextfield.text = ""
                destinationTextfield.text = ""
                startDateTextfield.text = ""
                endDateTextfield.text = ""
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let tripName = tripNametextfield.text, !tripName.isEmpty,
              let startLocation = startLocationTextfield.text, !startLocation.isEmpty,
              let destination = destinationTextfield.text, !destination.isEmpty,
              let startDateString = startDateTextfield.text, !startDateString.isEmpty,
              let endDateString = endDateTextfield.text, !endDateString.isEmpty else {
            // Show an alert if any of the required fields are empty
            let alert = UIAlertController(title: "Missing Information", message: "Please fill out all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Convert the string dates to Date objects
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        guard let startDate = formatter.date(from: startDateString),
              let endDate = formatter.date(from: endDateString) else {
            // Show an alert if the date conversion fails
            let alert = UIAlertController(title: "Invalid Date", message: "Please enter valid dates", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Create a new trip object
        let newTrip = Trip(context: context)
        newTrip.tripName = tripName
        newTrip.startLocation = startLocation
        newTrip.destination = destination
        newTrip.startDate = startDate
        newTrip.endDate = endDate
        
        // Save the data to Core Data
        do {
            try context.save()
            // Show a success message or navigate back
            let successAlert = UIAlertController(title: "Success", message: "Trip saved successfully", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(successAlert, animated: true, completion: nil)
        } catch {
            // Handle error
            let errorAlert = UIAlertController(title: "Error", message: "Failed to save trip. Please try again.", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
}
