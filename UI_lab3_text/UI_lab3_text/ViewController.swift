//
//  ViewController.swift
//  UI_lab3_text
//
//  Created by user228293 on 5/23/24.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var firstName_textfield: UITextField!
    @IBOutlet weak var lastName_textfield: UITextField!
    @IBOutlet weak var Country_textfield: UITextField!
    @IBOutlet weak var Age_textfield: UITextField!
    @IBOutlet weak var Output_textfield: UITextView!
    @IBOutlet weak var Message_Label: UILabel!
  
    
    @IBAction func addInformation_Button(_ sender: UIButton) {
        self.Output_textfield.text = "Name: \(self.firstName_textfield.text!) \(self.lastName_textfield.text!) \nCountry: \(self.Country_textfield.text!)  \nAge: \(self.Age_textfield.text!)"
    }
    
    @IBAction func Submit_Button(_ sender: UIButton) {
        if self.firstName_textfield.text == "" || self.lastName_textfield.text == "" || self.Country_textfield.text == "" || self.Age_textfield.text == "" {
            self.Message_Label.text = "Please fill all the details!"
        } else{
            self.Message_Label.text = "Successfully submitted!"
        }
    }
    
    @IBAction func Clear_Button(_ sender: UIButton) {
        self.firstName_textfield.text = ""
        self.lastName_textfield.text = ""
        self.Country_textfield.text = ""
        self.Age_textfield.text = ""
        self.Output_textfield.text = ""
        self.Message_Label.text = ""
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

