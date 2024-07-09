import UIKit

class TaskManager {
    static let shared = TaskManager()

    struct Task: Codable {
        var title: String
        var description: String
        var dueDate: String
        var status: String
        var imageData: Data?
        
        var image: UIImage? {
            if let data = imageData {
                return UIImage(data: data)
            }
            return nil
        }
    }

    private init() {
        loadTasks()
    }

    private(set) var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }

    private func saveTasks() {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
    }

    private func loadTasks() {
        if let savedTasksData = UserDefaults.standard.data(forKey: "tasks"),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: savedTasksData) {
            tasks = savedTasks
        } else {
            addDefaultTasks()
        }
    }

    private func addDefaultTasks() {
        let defaultTasks = [
            Task(title: "Complete Homework", description: "Math and Science assignments", dueDate: "07/10/2024", status: "Pending", imageData: UIImage(systemName: "doc.text")?.pngData()),
            Task(title: "Buy Groceries", description: "Milk, Bread, Eggs, and Vegetables", dueDate: "07/07/2024", status: "In Progress", imageData: UIImage(systemName: "cart")?.pngData())
        ]
        
        tasks.append(contentsOf: defaultTasks)
    }
}
