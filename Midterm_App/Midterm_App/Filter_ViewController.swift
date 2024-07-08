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
                      sortByStatusSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
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
        var sortByStatusSegmentedControl: UISegmentedControl!
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

            // Sort by Status Segmented Control
            sortByStatusSegmentedControl = UISegmentedControl(items: ["Pending", "In Progress", "Completed"])
            sortByStatusSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(sortByStatusSegmentedControl)

            // Status Filter Segmented Control
            statusFilterSegmentedControl = UISegmentedControl(items: ["All", "Pending", "In Progress", "Completed"])
            statusFilterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(statusFilterSegmentedControl)

            // Add constraints to position the segmented controls
            NSLayoutConstraint.activate([
                sortOrFilterSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                sortOrFilterSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                sortOrFilterSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                sortByDueDateSegmentedControl.topAnchor.constraint(equalTo: sortOrFilterSegmentedControl.bottomAnchor, constant: 20),
                sortByDueDateSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                sortByDueDateSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                sortByStatusSegmentedControl.topAnchor.constraint(equalTo: sortByDueDateSegmentedControl.bottomAnchor, constant: 20),
                sortByStatusSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                sortByStatusSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                statusFilterSegmentedControl.topAnchor.constraint(equalTo: sortByStatusSegmentedControl.bottomAnchor, constant: 20),
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
            sortByDueDateSegmentedControl.isHidden = !(show && isSort)
            sortByStatusSegmentedControl.isHidden = !(show && isSort)
            statusFilterSegmentedControl.isHidden = !(show && !isSort)
        }

        private func saveSettings() {
            let sortByDueDateIndex = sortByDueDateSegmentedControl.selectedSegmentIndex
            let sortByStatusIndex = sortByStatusSegmentedControl.selectedSegmentIndex
            let statusFilterIndex = statusFilterSegmentedControl.selectedSegmentIndex
            let sortOrFilterIndex = sortOrFilterSegmentedControl.selectedSegmentIndex

            UserDefaults.standard.set(sortByDueDateIndex, forKey: "sortByDueDate")
            UserDefaults.standard.set(sortByStatusIndex, forKey: "sortByStatus")
            UserDefaults.standard.set(statusFilterIndex, forKey: "statusFilter")
            UserDefaults.standard.set(sortOrFilterIndex, forKey: "sortOrFilter")
        }

        private func loadSettings() {
            let sortByDueDateIndex = UserDefaults.standard.integer(forKey: "sortByDueDate")
            let sortByStatusIndex = UserDefaults.standard.integer(forKey: "sortByStatus")
            let statusFilterIndex = UserDefaults.standard.integer(forKey: "statusFilter")
            let sortOrFilterIndex = UserDefaults.standard.integer(forKey: "sortOrFilter")

            sortByDueDateSegmentedControl.selectedSegmentIndex = sortByDueDateIndex
            sortByStatusSegmentedControl.selectedSegmentIndex = sortByStatusIndex
            statusFilterSegmentedControl.selectedSegmentIndex = statusFilterIndex
            sortOrFilterSegmentedControl.selectedSegmentIndex = sortOrFilterIndex

            sortOrFilterChanged()
        }
            /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
