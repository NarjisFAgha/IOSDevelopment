//
//  TaskManager.swift
//  Midterm_App
//
//  Created by user228293 on 7/6/24.
//

import UIKit

class TaskManager {
    static let shared = TaskManager()

    struct Task {
        var title: String
        var description: String
        var dueDate: String
        var status: String
        var image: UIImage?
    }

    private init() {
        addDefaultTasks()
    }

    var tasks: [Task] = [] {
        didSet {
            // Optional: Notify listeners about the update, if needed
        }
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }

    private func addDefaultTasks() {
        let defaultTasks = [
            Task(title: "Complete Homework", description: "Math and Science assignments", dueDate: "07/10/2024", status: "Pending", image: UIImage(systemName: "doc.text")),
            Task(title: "Buy Groceries", description: "Milk, Bread, Eggs, and Vegetables", dueDate: "07/07/2024", status: "In Progress", image: UIImage(systemName: "cart"))
        ]
        
        tasks.append(contentsOf: defaultTasks)
    }
}
