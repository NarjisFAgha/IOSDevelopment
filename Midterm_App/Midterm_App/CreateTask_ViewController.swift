//
//  CreateTask_ViewController.swift
//  Midterm_App
//
//  Created by user228293 on 7/6/24.
//

import UIKit

class CreateTask_ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var statusButton: UIButton!
    let datePicker = UIDatePicker()
       let statuses = ["Pending", "In Progress", "Completed"]
       var selectedStatusIndex: Int? // Track selected status index
       
       override func viewDidLoad() {
           super.viewDidLoad()

           // Date Picker Setup
           datePicker.datePickerMode = .date
           datePicker.preferredDatePickerStyle = .wheels
           datePicker.minimumDate = Date()
           datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
           dueDateTextField.inputView = datePicker
           
           // Toolbar for Date Picker
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDatePicker))
           let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           toolbar.setItems([flexibleSpace, doneButton], animated: true)
           dueDateTextField.inputAccessoryView = toolbar
           
           // Setup status button action
           statusButton.addTarget(self, action: #selector(showStatusAlert), for: .touchUpInside)
       }
       
       @objc func doneDatePicker() {
           view.endEditing(true)
       }

       @objc func dateChanged() {
           let formatter = DateFormatter()
           formatter.dateFormat = "MM/dd/yyyy"
           dueDateTextField.text = formatter.string(from: datePicker.date)
       }
       
       @objc func showStatusAlert() {
           let alert = UIAlertController(title: "Select Status", message: nil, preferredStyle: .actionSheet)
           
           for (index, status) in statuses.enumerated() {
               let action = UIAlertAction(title: status, style: .default) { (action) in
                   self.selectedStatusIndex = index
                   self.statusButton.setTitle(status, for: .normal)
               }
               alert.addAction(action)
           }
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alert.addAction(cancelAction)
           
           if let popoverController = alert.popoverPresentationController {
               popoverController.sourceView = self.statusButton
               popoverController.sourceRect = self.statusButton.bounds
           }
           
           present(alert, animated: true, completion: nil)
       }
    
    @IBAction func submitButton(_ sender: Any) {
        guard let title = taskTitleTextField.text, !title.isEmpty,
                     let dueDate = dueDateTextField.text, !dueDate.isEmpty,
                     let selectedStatusIndex = selectedStatusIndex else {
                   showAlert(message: "Title, due date, and status are mandatory.")
                   return
               }
               
               let status = statuses[selectedStatusIndex]
               let description = taskDescriptionTextField.text ?? ""
               
               guard let image = imageView.image else {
                   showAlert(message: "Please select an image.")
                   return
               }
               
               let task = TaskManager.Task(title: title, description: description, dueDate: dueDate, status: status, image: image)
               TaskManager.shared.addTask(task)
               
               showAlert(message: "Task created successfully!")
        resetFields()
           }
    func resetFields() {
          taskTitleTextField.text = ""
          taskDescriptionTextField.text = ""
          dueDateTextField.text = ""
        imageView.image = UIImage(systemName: "doc.fill.badge.plus")
          statusButton.setTitle("Select Status", for: .normal)
      }
    
    @IBAction func addImageButton(_ sender: Any) {
        // Open image picker to select an image
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
