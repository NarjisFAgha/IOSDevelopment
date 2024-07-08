import UIKit

class Task_List_TableViewController: UITableViewController {

    @IBOutlet weak var SettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0  // Provide an estimated row height
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let task = TaskManager.shared.tasks[indexPath.row]

        cell.titleLabel.text = task.title
        cell.titleLabel.numberOfLines = 0  // Enable multiple lines
        cell.statusLabel.text = task.status
        cell.statusLabel.numberOfLines = 0  // Enable multiple lines
        cell.dueDateLabel.text = task.dueDate
        cell.dueDateLabel.numberOfLines = 0


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
