//
//  TasksTableViewCell.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 22.04.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

class TasksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var checkedLabel: UILabel!
    @IBOutlet weak var taskCellLabel: UILabel!
    //var task = [Task]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(task: Task){
        
        taskCellLabel.text = task.title
        
        
    }
    
    func checkAccessoryTyp(for task: Task, with cell: TasksTableViewCell){
        
        if task.checked == true{
            cell.checkedLabel.text = "✔"
            task.checked = false
        }else{
            cell.checkedLabel.text = ""
            task.checked = true
        }
    }
    
}

//extension UITableViewCell {
//
//    var indexPath: IndexPath? {
//        return (superview as? UITableView)?.indexPath(for: self)
//    }
//}
