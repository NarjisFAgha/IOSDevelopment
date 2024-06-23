//
//  ViewController.swift
//  assingment2
//
//  Created by user228293 on 6/22/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LaptopsButton(_ sender: Any) {
        
    }
    
    @IBAction func MonitorsButton(_ sender: Any) {
        let alert = UIAlertController(title: "Error", message: "No Monitors yet. Check back later!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
    }
    
}

