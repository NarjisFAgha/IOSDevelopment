//
//  Filter_ViewController.swift
//  Midterm_App
//
//  Created by user228293 on 7/6/24.
//

import UIKit

class Filter_ViewController: UIViewController {


    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var SettingLabel: UILabel!
    
    @IBAction func ClearButton(_ sender: Any) {
        sortByDueDateSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        statusFilterSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        sortOrFilterSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        toggleSortAndFilterControls(show: false)
        saveSettings()
    }
    
    @IBAction func ApplyButton(_ sender: Any) {
        saveSettings()
        // Dismiss the settings view
        navigationController?.popViewController(animated: true)
    }
    
    var sortOrFilterSegmentedControl: UISegmentedControl!
    var sortByDueDateSegmentedControl: UISegmentedControl!
    var statusFilterSegmentedControl: UISegmentedControl!


    override func viewDidLoad() {
           super.viewDidLoad()
           setupSegmentedControls()
           loadSettings()
       }

       func setupSegmentedControls() {
           // Sort or Filter Segmented Control
           sortOrFilterSegmentedControl = UISegmentedControl(items: ["Sort", "Filter"])
           sortOrFilterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
           sortOrFilterSegmentedControl.addTarget(self, action: #selector(sortOrFilterChanged), for: .valueChanged)
           view.addSubview(sortOrFilterSegmentedControl)

           // Sort by Due Date Segmented Control
           sortByDueDateSegmentedControl = UISegmentedControl(items: ["Ascending", "Descending"])
           sortByDueDateSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(sortByDueDateSegmentedControl)

           // Status Filter Segmented Control
           statusFilterSegmentedControl = UISegmentedControl(items: ["All", "Pending", "In Progress", "Completed"])
           statusFilterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(statusFilterSegmentedControl)

           // Add constraints to position the segmented controls
           NSLayoutConstraint.activate([
               sortOrFilterSegmentedControl.topAnchor.constraint(equalTo: SettingLabel.bottomAnchor, constant: 20),
               sortOrFilterSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               sortOrFilterSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

               sortByDueDateSegmentedControl.topAnchor.constraint(equalTo: sortOrFilterSegmentedControl.bottomAnchor, constant: 10),
               sortByDueDateSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               sortByDueDateSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
               statusFilterSegmentedControl.topAnchor.constraint(equalTo: sortOrFilterSegmentedControl.bottomAnchor, constant: 10),
               statusFilterSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               statusFilterSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
           ])

           // Initially hide sort and filter controls
           toggleSortAndFilterControls(show: false)
       }

       @objc func sortOrFilterChanged() {
           if sortOrFilterSegmentedControl.selectedSegmentIndex == 0 {
               // Sort selected
               toggleSortAndFilterControls(show: true, isSort: true)
           } else if sortOrFilterSegmentedControl.selectedSegmentIndex == 1 {
               // Filter selected
               toggleSortAndFilterControls(show: true, isSort: false)
           } else {
               // No selection
               toggleSortAndFilterControls(show: false)
           }
       }

       func toggleSortAndFilterControls(show: Bool, isSort: Bool = true) {
           if show {
               if isSort {
                   sortByDueDateSegmentedControl.isHidden = false
                   statusFilterSegmentedControl.isHidden = true
               } else {
                   sortByDueDateSegmentedControl.isHidden = true
                   statusFilterSegmentedControl.isHidden = false
               }
           } else {
               sortByDueDateSegmentedControl.isHidden = true
               statusFilterSegmentedControl.isHidden = true
           }
       }

       private func saveSettings() {
           let sortByDueDateIndex = sortByDueDateSegmentedControl.selectedSegmentIndex
           let statusFilterIndex = statusFilterSegmentedControl.selectedSegmentIndex
           let sortOrFilterIndex = sortOrFilterSegmentedControl.selectedSegmentIndex

           UserDefaults.standard.set(sortByDueDateIndex, forKey: "sortByDueDate")
           UserDefaults.standard.set(statusFilterIndex, forKey: "statusFilter")
           UserDefaults.standard.set(sortOrFilterIndex, forKey: "sortOrFilter")
       }

       private func loadSettings() {
           let sortByDueDateIndex = UserDefaults.standard.integer(forKey: "sortByDueDate")
           let statusFilterIndex = UserDefaults.standard.integer(forKey: "statusFilter")
           let sortOrFilterIndex = UserDefaults.standard.integer(forKey: "sortOrFilter")

           sortByDueDateSegmentedControl.selectedSegmentIndex = sortByDueDateIndex
           statusFilterSegmentedControl.selectedSegmentIndex = statusFilterIndex
           sortOrFilterSegmentedControl.selectedSegmentIndex = sortOrFilterIndex

           sortOrFilterChanged()
       }
   }
