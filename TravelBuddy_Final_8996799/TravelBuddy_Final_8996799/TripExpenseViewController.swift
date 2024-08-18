//
//  TripExpenseViewController.swift
//  TravelBuddy_Final_8996799
//
//  Created by user228293 on 8/17/24.
//

import UIKit
import CoreData

class TripExpenseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listOfExpensesTableView: UITableView!
    @IBOutlet weak var amounttextfield: UITextField!
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var tripName: UILabel!
    var trip: Trip?
    var expenses: [Expense] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfExpensesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
        listOfExpensesTableView.dataSource = self
        listOfExpensesTableView.delegate = self
        
        fetchExpenses()  // Fetch all expenses when the view loads
    }
    
    @IBAction func resetButton(_ sender: Any) {
        expenseName.text = ""
        amounttextfield.text = ""
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let name = expenseName.text, !name.isEmpty,
              let amountText = amounttextfield.text, let amount = Double(amountText) else {
            showAlert(message: "Please enter valid expense details.")
            return
        }
        
        let newExpense = Expense(context: context)
        newExpense.name = name
        newExpense.amount = amount
        newExpense.trip = trip
        
        do {
            try context.save()
            expenses.append(newExpense)  // Append the new expense to the array
            listOfExpensesTableView.reloadData()  // Reload the table view to reflect the new data
            updateTotalExpense()  // Update the total expense
        } catch {
            print("Failed to save expense: \(error)")
        }
    }
    
    func fetchExpenses() {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "trip == %@", trip!)
        
        do {
            expenses = try context.fetch(request)
            listOfExpensesTableView.reloadData()  // Reload the table view to show all expenses
            updateTotalExpense()  // Update the total expense
        } catch {
            print("Failed to fetch expenses: \(error)")
        }
    }
    
    func updateTotalExpense() {
        let total = expenses.reduce(0) { $0 + $1.amount }
        if let tripDetailVC = self.navigationController?.viewControllers.first(where: { $0 is TripDetailViewController }) as? TripDetailViewController {
            tripDetailVC.totalExpense.text = "Total Expense: $\(total)"
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count  // Return the correct number of expenses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ExpenseCell")
        
        // Set the cell's textLabel to the expense name
        let expense = expenses[indexPath.row]
        cell.textLabel?.text = expense.name
        
        // Set the cell's detailTextLabel to the formatted expense amount
        cell.detailTextLabel?.text = String(format: "$%.2f", expense.amount)
        
        return cell
    }

}

