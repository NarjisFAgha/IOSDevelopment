//
//  TodoViewController.swift
//  Lab6
//
//  Created by user228293 on 7/8/24.
//

import UIKit


class TodoItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Section {
    var name: String
    var items: [TodoItem]
    
    init(name: String, items: [TodoItem] = []) {
        self.name = name
        self.items = items
    }
}

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TodoListTextFeild: UITextField!
    @IBOutlet weak var SectionTextFeild: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    var sections: [Section] = []
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Hardcoded sections with to-do items
                 sections = [
                     Section(name: "Groceries", items: [TodoItem(name: "Buy milk"), TodoItem(name: "Buy eggs")]),
                     Section(name: "Work", items: [TodoItem(name: "Finish report"), TodoItem(name: "Email client")]),
                     Section(name: "Home", items: [TodoItem(name: "Clean kitchen"), TodoItem(name: "Mow lawn")]),
                     Section(name: "Fitness", items: [TodoItem(name: "Morning run"), TodoItem(name: "Gym session")]),
                     Section(name: "Hobbies", items: [TodoItem(name: "Read book"), TodoItem(name: "Paint landscape")]),
                     Section(name: "Travel", items: [TodoItem(name: "Book flight"), TodoItem(name: "Pack luggage")]),
                     Section(name: "Shopping", items: [TodoItem(name: "Buy new shoes"), TodoItem(name: "Order new laptop")]),
                     Section(name: "Health", items: [TodoItem(name: "Doctor appointment"), TodoItem(name: "Buy vitamins")])
                 ]
                 
                 tableview.delegate = self
                 tableview.dataSource = self
                 tableview.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
             }
    @IBAction func ClearButton(_ sender: Any) {
        TodoListTextFeild.text = ""
        SectionTextFeild.text = ""
    }
    @IBAction func AddButton(_ sender: Any) {
        guard let sectionName = SectionTextFeild.text, !sectionName.isEmpty,
                     let todoName = TodoListTextFeild.text, !todoName.isEmpty else {
                   let alert = UIAlertController(title: "Error", message: "Please enter both section and to-do item", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   present(alert, animated: true, completion: nil)
                   return
               }
               
               if let section = sections.first(where: { $0.name == sectionName }) {
                   section.items.append(TodoItem(name: todoName))
               } else {
                   let newSection = Section(name: sectionName, items: [TodoItem(name: todoName)])
                   sections.append(newSection)
               }
               
        tableview.reloadData()
        ClearButton(sender)
           }
           
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sections[section].items.count
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sections[section].name
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
            let item = sections[indexPath.section].items[indexPath.row]
            cell.textLabel?.text = item.name
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                sections[indexPath.section].items.remove(at: indexPath.row)
                if sections[indexPath.section].items.isEmpty {
                    // Remove rows instead of section to retain the section
                    tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
