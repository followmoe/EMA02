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
    
    var task = [Task]()
    
    let task1 = Task(title: "ios", category: "Privat")
    let task2 = Task(title: "android", category: "Hobby")
    let task3 = Task(title: "windows", category: "Studium")
    let task4 = Task(title: "macos", category: "Privat")
    
    
    
    //    func filter(_ task: [Task], category: String)-> [String]{
    //
    //        task.filter({return $0.category == category})
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        task.append(task1)
        task.append(task2)
        task.append(task3)
        task.append(task4)
        
        
        
        self.tableView.reloadData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    /* -----------------------------TableView--------------------------*/
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    //    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //        let movedObject = self.task[sourceIndexPath.row]
    //        task.remove(at: sourceIndexPath.row)
    //        task.insert(movedObject, at: destinationIndexPath.row)
    //        self.tableView.reloadData()
    //    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //        if section == 0{
        //
        //            let job = self.task.filter({return $0.category == "Beruf"})
        //            return job.count
        //        }
        //
        //        if section == 1{
        //            let university = self.task.filter({return $0.category == "Studium"})
        //            return university.count
        //        }
        //
        //        if section == 2{
        //            let shopping = self.task.filter({return $0.category == "Einkaufen"})
        //            return shopping.count
        //
        //        }
        //
        //        if section == 3{
        //            let privat = self.task.filter({return $0.category == "Privat"})
        //            return privat.count
        //
        //        }
        //
        //        if section == 4{
        //            let hobby = self.task.filter({return $0.category == "Hobby"})
        //            return hobby.count
        //
        //        }
        
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
        
        let tasks = task[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! TasksTableViewCell
        
        
        cell.checkAccessoryTyp(for: tasks, with: cell)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //allows edit of row
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //delete by swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            task.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //segue when accessorybutton is tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let tasks = task[indexPath.row]
        let index = indexPath.row
        tasks.index = index
        print(tasks.category)
        performSegue(withIdentifier: "detailTask", sender: tasks)
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        if section == 0 {
    //            return "Beruf"
    //        }else if section == 1{
    //            return "Studium"
    //        }else if section == 2 {
    //            return "Einkaufen"
    //        }else if section == 3{
    //            return "Privat"
    //        }else {
    //            return "Hobby"
    //        }
    //    }
    
    
    
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
        
        
        //        if category == "Beruf"{
        //            let indexPath = IndexPath(item: task.index, section: 0)
        //            if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
        //                cell.taskCellLabel.text = task.title
        //            }
        //        }
        //        if category == "Studium"{
        //            let indexPath = IndexPath(item: task.index, section: 1)
        //            if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
        //                cell.taskCellLabel.text = task.title
        //            }
        //        }
        //        if category == "Einkaufen"{
        //            let indexPath = IndexPath(item: task.index, section: 2)
        //            if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
        //                cell.taskCellLabel.text = task.title
        //            }
        //        }
        //        if category == "Privat"{
        //            let indexPath = IndexPath(item: task.index, section: 3)
        //            if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
        //                cell.taskCellLabel.text = task.title
        //            }
        //        }
        //        if category == "Hobby"{
        //            let indexPath = IndexPath(item: task.index, section: 4)
        //            if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
        //                cell.taskCellLabel.text = task.title
        //            }
        //        }
        let indexPath = IndexPath(item: task.index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? TasksTableViewCell{
            cell.taskCellLabel.text = task.title
            cell.categoryLabel.text = task.category
        }
        
        taskDetailVC.dismiss(animated: true, completion: nil)
    }
    
    func detailView(_ controller: UIViewController, didFinishAdding task: Task) {
        let addTaskVC = controller as! AddTaskViewController
        let count = self.task.count
        self.task.append(task)
        let indexPath = IndexPath(row: count, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        //        cell.checkAccessoryTyp(for: task, at: cell)
        //        vllt unnötig?
        
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
            
            if let task = sender as? Task{
                task.index = self.task.count
                controller.addTask = task
            }
            
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
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */


