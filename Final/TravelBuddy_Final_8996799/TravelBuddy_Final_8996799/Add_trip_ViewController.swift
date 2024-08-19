//
//  Add_trip_ViewController.swift
//  TravelBuddy_Final_8996799
//
//  Created by user228293 on 8/17/24.
//

import UIKit
import CoreLocation
import CoreData

class Add_trip_ViewController: UIViewController {
    
    @IBOutlet weak var tripNamelabel: UILabel!
    
    @IBOutlet weak var endDateTextfield: UITextField!
    @IBOutlet weak var startDateTextfield: UITextField!
    @IBOutlet weak var destinationTextfield: UITextField!
    @IBOutlet weak var startLocationTextfield: UITextField!
    @IBOutlet weak var tripNametextfield: UITextField!
    
    let datePicker = UIDatePicker()
        let toolbar = UIToolbar()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let geocoder = CLGeocoder()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupDatePickers()
        }
        
        func setupDatePickers() {
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
            datePicker.minimumDate = Date()
            
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
            toolbar.setItems([doneButton], animated: false)
            toolbar.isUserInteractionEnabled = true
            
            startDateTextfield.inputAccessoryView = toolbar
            startDateTextfield.inputView = datePicker
            
            endDateTextfield.inputAccessoryView = toolbar
            endDateTextfield.inputView = datePicker
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
        
        @objc func doneButtonTapped() {
            view.endEditing(true)
        }
    
    @IBAction func clearButton(_ sender: Any) {
        // Clear all text fields
        tripNametextfield.text = ""
        startLocationTextfield.text = ""
        destinationTextfield.text = ""
        startDateTextfield.text = ""
        endDateTextfield.text = ""
    }
    
    func isValidLocation(_ location: String, completion: @escaping (Bool) -> Void) {
        // Check if the location is too short or vague
        guard location.count > 2 else {
            print("Location too vague: \(location)")
            completion(false)
            return
        }
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No valid location found for: \(location)")
                completion(false)
                return
            }
            
            print("Geocoded location: \(String(describing: placemark.locality))")
            completion(true)
        }
    }

        
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let tripName = tripNametextfield.text, !tripName.isEmpty,
                     let startLocation = startLocationTextfield.text, !startLocation.isEmpty,
                     let destination = destinationTextfield.text, !destination.isEmpty,
                     let startDateString = startDateTextfield.text, !startDateString.isEmpty,
                     let endDateString = endDateTextfield.text, !endDateString.isEmpty else {
                   showAlert(title: "Missing Information", message: "Please fill out all fields")
                   return
               }
               
               let formatter = DateFormatter()
               formatter.dateStyle = .medium
               formatter.timeStyle = .none
               
               guard let startDate = formatter.date(from: startDateString),
                     let endDate = formatter.date(from: endDateString) else {
                   showAlert(title: "Invalid Date", message: "Please enter valid dates")
                   return
               }
               
               if endDate < startDate {
                   showAlert(title: "Invalid Dates", message: "The end date cannot be before the start date.")
                   return
               }
               
               isValidLocation(startLocation) { isValidStartLocation in
                   guard isValidStartLocation else {
                       self.showAlert(title: "Invalid Start Location", message: "Please enter a valid start location.")
                       return
                   }
                   
                   self.isValidLocation(destination) { isValidDestination in
                       guard isValidDestination else {
                           self.showAlert(title: "Invalid Destination", message: "Please enter a valid destination.")
                           return
                       }
                       
                       self.saveTrip(tripName: tripName, startLocation: startLocation, destination: destination, startDate: startDate, endDate: endDate)
                   }
               }
           }
           
           func saveTrip(tripName: String, startLocation: String, destination: String, startDate: Date, endDate: Date) {
               let newTrip = Trip(context: context)
               newTrip.tripName = tripName
               newTrip.startLocation = startLocation
               newTrip.destination = destination
               newTrip.startDate = startDate
               newTrip.endDate = endDate
               
               do {
                   try context.save()
                   let successAlert = UIAlertController(title: "Success", message: "Trip saved successfully", preferredStyle: .alert)
                   successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                       self.navigationController?.popViewController(animated: true)
                   }))
                   self.present(successAlert, animated: true, completion: nil)
               } catch {
                   let errorAlert = UIAlertController(title: "Error", message: "Failed to save trip. Please try again.", preferredStyle: .alert)
                   errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(errorAlert, animated: true, completion: nil)
               }
           }
       }
