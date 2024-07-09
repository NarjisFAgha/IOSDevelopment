//
//  TaskDetailViewController.swift
//  Midterm_App
//
//  Created by user228293 on 7/6/24.
//

import UIKit

class TaskDetailViewController: UIViewController {
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    var task: taskHandler.task?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let task = task {
                taskTitleLabel.text = task.title
                taskDescriptionLabel.text = task.description
                dueDateLabel.text = task.dueDate
                statusLabel.text = task.status
                if let image = task.image {
                    imageView.image = image
                } else {
                    imageView.image = UIImage(systemName: "photo")
                }
            }
        }
    
}
