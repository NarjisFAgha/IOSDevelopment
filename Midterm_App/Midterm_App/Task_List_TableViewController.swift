import UIKit

class Task_List_TableViewController: UITableViewController {

    @IBOutlet weak var SettingButton: UIButton!
    
    var filteredTasks: [TaskManager.Task] = []
       var currentFilters = FilterSettings()

       override func viewDidLoad() {
           super.viewDidLoad()
//           tableView.rowHeight = UITableView.automaticDimension
//           tableView.estimatedRowHeight = 50.0
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           loadFilters()
           applyFilters()
           tableView.reloadData()  // Reload data when the view appears
       }

       func loadFilters() {
           currentFilters.sortByDueDate = UserDefaults.standard.integer(forKey: "sortByDueDate")
           currentFilters.sortByStatus = UserDefaults.standard.integer(forKey: "sortByStatus")
           currentFilters.statusFilter = UserDefaults.standard.integer(forKey: "statusFilter")
           currentFilters.sortOrFilter = UserDefaults.standard.integer(forKey: "sortOrFilter")
       }

       func applyFilters() {
           filteredTasks = TaskManager.shared.tasks
           
           if currentFilters.sortOrFilter == 1 { // Filter
               switch currentFilters.statusFilter {
               case 1:
                   filteredTasks = filteredTasks.filter { $0.status == "Pending" }
               case 2:
                   filteredTasks = filteredTasks.filter { $0.status == "In Progress" }
               case 3:
                   filteredTasks = filteredTasks.filter { $0.status == "Completed" }
               default:
                   break
               }
           } else if currentFilters.sortOrFilter == 0 { // Sort
               if currentFilters.sortByDueDate != UISegmentedControl.noSegment {
                   filteredTasks.sort {
                       currentFilters.sortByDueDate == 0 ? $0.dueDate < $1.dueDate : $0.dueDate > $1.dueDate
                   }
               }
               
               if currentFilters.sortByStatus != UISegmentedControl.noSegment {
                   filteredTasks.sort {
                       currentFilters.sortByStatus == 0 ? $0.status < $1.status : $0.status > $1.status
                   }
               }
           }
       }

       // MARK: - Table view data source

       override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return filteredTasks.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else {
               return UITableViewCell()
           }
           let task = filteredTasks[indexPath.row]

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
               let taskToRemove = filteredTasks[indexPath.row]
               if let index = TaskManager.shared.tasks.firstIndex(where: { $0.title == taskToRemove.title }) {
                   TaskManager.shared.tasks.remove(at: index)
                   applyFilters()
                   tableView.deleteRows(at: [indexPath], with: .fade)
               }
           }
       }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
       // Navigation to detailed task view
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showTaskDetail",
              let destinationVC = segue.destination as? TaskDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow {
               destinationVC.task = filteredTasks[indexPath.row]
           }
       }
   }

   struct FilterSettings {
       var sortByDueDate: Int = UISegmentedControl.noSegment
       var sortByStatus: Int = UISegmentedControl.noSegment
       var statusFilter: Int = UISegmentedControl.noSegment
       var sortOrFilter: Int = UISegmentedControl.noSegment
   }
