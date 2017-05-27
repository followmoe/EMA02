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
    
    
    
    @IBOutlet weak var checkedButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var taskCellLabel: UILabel!
    var taskId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func updateUI(task: Task){
        taskId = task.taskId
        taskCellLabel.text = task.title
        categoryLabel.text = task.category
        checkedButton.isHidden = task.checked
        
        
        
    }
    func updateTaskIfChecked(when ButtonIsHidden: Bool, for cell: TasksTableViewCell) {
        if let realm = try? Realm(),
            let id = self.taskId,
            let task = realm.object(ofType: Task.self, forPrimaryKey: id as AnyObject) {
            
            try! realm.write {
                    task.checked = ButtonIsHidden
            }
            cell.checkedButton.isHidden = task.checked
        }
    }
    
}
