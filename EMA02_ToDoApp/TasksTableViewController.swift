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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task1 = Task(title: "ios")
        let task2 = Task(title: "android")
        let task3 = Task(title: "windows")
        let task4 = Task(title: "macos")
        task.append(task1)
        task.append(task2)
        task.append(task3)
        task.append(task4)
        tableView.reloadData()
        
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return task.count
    }
    
    //creates cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as? TasksTableViewCell{
            let tasks = task[indexPath.row]
            cell.updateUI(task: tasks)
            //            var buttonTag = cell.cellButton.tag
            //            buttonTag = indexPath.row
            //            cell.cellButton.addTarget(self, action:#selector(TasksTableViewController.detailViewOfTask), for: .touchUpInside)
            return cell
        }else {
            
            return UITableViewCell()
            
        }
    }
    //action when row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tasks = task[indexPath.row]
        let customTableViewCell = TasksTableViewCell()
        
        
        if let cell = tableView.cellForRow(at: indexPath){
            
            customTableViewCell.checkAccessoryTyp(for: tasks, at: cell)
            tableView.deselectRow(at: indexPath, animated: true)
        }
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
        performSegue(withIdentifier: "detailTask", sender: tasks)
    }
    
    /*-----------------------------------End TableView Implementation--------------------------------------*/
    
    /*-------------------------------------Protocol TaskViewDelegate---------------------------------------*/
    
    func detailViewDidCancel(_ controller: UIViewController) {
        let taskDetailVC = controller as! TaskDetailViewController
        print("Delegation works!")
        
        taskDetailVC.dismiss(animated: true, completion: nil)
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
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */


