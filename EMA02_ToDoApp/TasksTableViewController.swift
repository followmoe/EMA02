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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    /* -----------------------------TableView--------------------------*/
    
    // returns number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    // Moving rows implementation.
    //    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //        let movedObject = self.task[sourceIndexPath.row]
    //        task.remove(at: sourceIndexPath.row)
    //        task.insert(movedObject, at: destinationIndexPath.row)
    //        self.tableView.reloadData()
    //    }
    //
    //    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    
    //return number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return task.count
    }
    
    //creates cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as? TasksTableViewCell{
            let tasks = task[indexPath.row]
            cell.updateUI(task: tasks)
            return cell
        }else {
            
            return UITableViewCell()
            
        }
    }
    //action when row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TasksTableViewCell
        cell.updateTaskIfChecked(when: !cell.checkedButton.isHidden, for: cell)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //allows edit of row
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //TODO: delete Task from Realm
    //delete by swipe
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
        //TODO: update index in realm
        let realm = try! Realm()
        
        try! realm.write {
            tasks.index = index
        }
        performSegue(withIdentifier: "detailTask", sender: tasks)
    }
    
    /*-----------------------------------End TableView Implementation--------------------------------------*/
    
    /*-------------------------------------Protocol TaskViewDelegate---------------------------------------*/
    
    func detailViewDidCancel(_ controller: UIViewController, identifier: String) {
        
        if identifier == "addTask"{
            let addTaskVC = controller as! AddTaskViewController
            addTaskVC.dismiss(animated: true, completion: nil)
        }
        if identifier == "editTask"{
            let taskDetailVC = controller as! TaskDetailViewController
            taskDetailVC.dismiss(animated: true, completion: nil)
        }
    }
    
    //Edit Cell Text !!!
    func detailView(_ controller: UIViewController, didFinishEditing task: Task) {
        let taskDetailVC = controller as! TaskDetailViewController
        let indexPath = IndexPath(item: task.index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
            cell.taskCellLabel.text = task.title
            cell.categoryLabel.text = task.category
        }
        //TODO: Update Realm
        taskDetailVC.dismiss(animated: true, completion: nil)
    }
    
    func detailView(_ controller: UIViewController, didFinishAdding task: Task) {
        let realm = try! Realm()
        let addTaskVC = controller as! AddTaskViewController
        try! realm.write {
            realm.add(task)
        }
        
        addTaskVC.dismiss(animated: true, completion: nil)
    }
    
    
    /*-------------------------------------------End Protocoll TaskViewDelegate----------------------------*/
    
    /*-------------------------------------Segue------------------------------------------------------------*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailTask"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! TaskDetailViewController
            controller.delegate = self
            
            if let task = sender as? Task{
                controller.detailTask = task
            }
        }
        
        
        if segue.identifier == "addTask"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddTaskViewController
            controller.delegate = self
        }
    }
    /*--------------------------------------------Segue-----------------------------------------------------*/
}



/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 */


