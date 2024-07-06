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
    
    @IBOutlet weak var statusTextField: UITextField!
  
    @IBOutlet weak var imageView: UIImageView!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureDatePicker()
    }
    func configureDatePicker() {
            // Set the date picker mode
            datePicker.datePickerMode = .date
            
            // Set the date picker to the text field's input view
            dueDateTextField.inputView = datePicker
            
            // Create a toolbar with a done button
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
            toolbar.setItems([doneButton], animated: true)
            dueDateTextField.inputAccessoryView = toolbar
        }
    @objc func doneButtonTapped() {
            // Format the date and set it to the text field
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            dueDateTextField.text = formatter.string(from: datePicker.date)
            
            // Dismiss the date picker
            view.endEditing(true)
        }
    
    
    @IBAction func submitButton(_ sender: Any) {
        guard let title = taskTitleTextField.text, !title.isEmpty,
        let dueDate = dueDateTextField.text, !dueDate.isEmpty
        else { showAlert(message: "Title and due date are mandatory.")
        return
        }
                
        // Optionally handle task description and status
                        let description = taskDescriptionTextField.text ?? ""
                        let status = statusTextField.text ?? ""
                        
                        // Handle task creation logic here
                        // For example, save the task to an array or a database
                        let task = Task(title: title, description: description, dueDate: dueDate, status: status, image: imageView.image)
                        // Save the task (implementation depends on your app's data storage solution)
                        
                        // Show success message or navigate to another screen
                        showAlert(message: "Task created successfully!")
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
    

    // Define a Task model (replace with your actual model if you have one)
    struct Task {
        var title: String
        var description: String
        var dueDate: String
        var status: String
        var image: UIImage?
        
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
