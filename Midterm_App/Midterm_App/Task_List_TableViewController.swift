//
//  Task_List_TableViewController.swift
//  Midterm_App
//
//  Created by user228293 on 7/3/24.
//

// Task_List_TableViewController.swift

import UIKit

class Task_List_TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()  // Reload data when the view appears
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = TaskManager.shared.tasks[indexPath.row]

        cell.textLabel?.text = task.title
        cell.textLabel?.numberOfLines = 0  // Enable multiple lines
        cell.detailTextLabel?.text = "Due: \(task.dueDate) | Status: \(task.status)"
        cell.detailTextLabel?.numberOfLines = 0  // Enable multiple lines

        return cell
    }

    // Swipe to delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TaskManager.shared.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Navigation to detailed task view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail",
           let destinationVC = segue.destination as? TaskDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.task = TaskManager.shared.tasks[indexPath.row]
        }
    }
}
