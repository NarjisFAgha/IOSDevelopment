//
//  ViewController.swift
//  UI_lab4
//
//  Created by user228293 on 5/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Title_Label: UILabel!
    @IBOutlet weak var 	Image_stack: UIStackView!
    @IBOutlet weak var Img1: UIImageView!
    @IBOutlet weak var Img2: UIImageView!
    @IBOutlet weak var Img3: UIImageView!
    @IBOutlet weak var FirstName_Label: UILabel!
    @IBOutlet weak var SurName_Label: UILabel!
    @IBOutlet weak var Address_Label: UILabel!
    @IBOutlet weak var City_Label: UILabel!
    @IBOutlet weak var DOB_Label: UILabel!
    @IBOutlet weak var Detail_stack: UIStackView!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var SurName: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var DOB: UITextField!
    @IBOutlet weak var Output: UITextView!
    
    func isValidDOB(_ dob: String?) -> Bool {
           guard let dobText = dob else { return false }
           
           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
           
           guard let date = formatter.date(from: dobText) else { return false }
           
           let age = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
           
           return age > 18
       }
       
       func updateOutput() {
           guard let firstName = FirstName.text, !firstName.isEmpty,
                 let surname = SurName.text, !surname.isEmpty,
                 let address = Address.text, !address.isEmpty,
                 let city = City.text, !city.isEmpty,
                 let dob = DOB.text, !dob.isEmpty, isValidDOB(dob) else {
               Output.text = "Please fill in all fields and ensure the age is over 18."
               return
           }
           
           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
           let date = formatter.date(from: dob)!
           let age = Calendar.current.dateComponents([.year], from: date, to: Date()).year!
           
           Output.text = """
           I, \(firstName) \(surname), currently living at \(address) in the city of \(city) do hereby accept the terms and conditions assignment.
           I am \(age) and therefore am able to accept the conditions of this assignment.
           """
       }
       
       
    
    
    @IBAction func Reset(_ sender: Any) {
        self.FirstName.text = ""
        self.SurName.text = ""
        self.Address.text = ""
        self.City.text = ""
        self.DOB.text = ""
        self.Output.text = ""
    }
    
    @IBAction func Decline(_ sender: Any) {
        self.FirstName.text = ""
        self.SurName.text = ""
        self.Address.text = ""
        self.City.text = ""
        self.DOB.text = ""
        self.Output.text = "You have Declined."
    }
    
    @IBAction func Accept(_ sender: Any) {
       
        updateOutput()
              
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

