//
//  TaskTableViewCell.swift
//  Midterm_App
//
//  Created by user228293 on 7/6/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!

    override func awakeFromNib() {
           super.awakeFromNib()
       }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
}	
