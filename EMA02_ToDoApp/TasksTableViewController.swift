//
//  TasksTableViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 20.04.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

class TasksTableViewController: UITableViewController, TaskViewDelegate{
    
    var task: Results<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        task = realm.objects(Task.self)
        tableView.reloadData()

    }
    
}

extension TasksTableViewController {
    // returns number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    //return number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return task.count
    }
    
    //creates cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TasksTableViewCell
            let tasks = task[indexPath.row]
            cell.updateUI(task: tasks)
            return cell
        
    }
    //action when row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell {
            cell.updateTaskIfChecked(when: !cell.checkedButton.isHidden)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //allows edit of row
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! task.realm!.write {
                let task = self.task[indexPath.row]
                self.task.realm!.delete(task)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //segue when accessorybutton is tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let tasks = task[indexPath.row]
        let index = indexPath.row
        let realm = try! Realm()
        
        try! realm.write {
            tasks.index = index
        }
        performSegue(withIdentifier: "detailTask", sender: tasks)
    }
}

extension TasksTableViewController {
    func detailViewDidCancel(_ controller: UIViewController) {
        if let taskDetailVC = controller as? TaskDetailViewController {
            taskDetailVC.dismiss(animated: true, completion: nil)
        }
    }
    
    //Edit Cell Text !!!
    func detailView(_ controller: UIViewController, didFinishEditing task: Task) {
        let realm = try! Realm()
        if let taskDetailVC = controller as? TaskDetailViewController {
            
            try! realm.write {
                realm.add(task, update: true)
            }
            
            taskDetailVC.dismiss(animated: true, completion: {
                self.tableView.reloadData()
            })
        }
    }
    
    func detailView(_ controller: UIViewController, didFinishAdding task: Task) {
        let realm = try! Realm()
        if let addTaskVC = controller as? TaskDetailViewController {
            try! realm.write {
                realm.add(task)
            }
            addTaskVC.dismiss(animated: true, completion: {
                self.tableView.reloadData()
            })
        }
    }
}
    
extension TasksTableViewController {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailTask"{
            if let navigationController = segue.destination as? UINavigationController, let controller = navigationController.topViewController as? TaskDetailViewController {
                controller.delegate = self
                controller.controllerLabel = "Edit Task"
                if let task = sender as? Task {
                    controller.detailTask = task
                    controller.category = task.category
                }
            }
        }
        
        if segue.identifier == "addTask"{
            if let navigationController = segue.destination as? UINavigationController, let controller = navigationController.topViewController as? TaskDetailViewController {
                controller.delegate = self
                controller.title = "Add Task"
                controller.controllerLabel = "Add new Task:"
            }
        }
    }
   
}


