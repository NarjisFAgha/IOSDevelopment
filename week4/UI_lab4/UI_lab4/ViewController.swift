//
//  ViewController.swift
//  UI_lab4
//
//  Created by user228293 on 5/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Title_Label: UILabel!
    @IBOutlet weak var Image_stack: UIStackView!
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
        self.Output.text = ""
        self.Output.text = "You have Declined."
    }
    
    @IBAction func Accept(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

