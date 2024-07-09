import UIKit

class taskHandler {
    static let shared = taskHandler()

    struct task: Codable {
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
        taskloading()
    }

    private(set) var tasks: [task] = [] {
        didSet {
            savingtask()
        }
    }
    
    func taskappending(_ task: task) {
        tasks.append(task)
    }

    func taskremoval(at index: Int) {
        tasks.remove(at: index)
    }

    private func savingtask() {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
    }

    private func taskloading() {
        if let savedTasksData = UserDefaults.standard.data(forKey: "tasks"),
           let savedTasks = try? JSONDecoder().decode([task].self, from: savedTasksData) {
            tasks = savedTasks
        } else {
            DefaultTasks()
        }
    }

    private func DefaultTasks() {
        let defaultTasks = [
            task(title: "Complete Homework", description: "Math and Science assignments", dueDate: "09/28/2024", status: "Pending", imageData: UIImage(systemName: "doc.text")?.pngData()),
            task(title: "Buy Groceries", description: "Milk, Bread, Eggs, and Vegetables", dueDate: "08/25/2024", status: "In Progress", imageData: UIImage(systemName: "cart")?.pngData())
        ]
        
        tasks.append(contentsOf: defaultTasks)
    }
}
