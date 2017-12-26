//
//  ManageCategorysTableViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 28.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

class ManageCategorysTableViewController: UITableViewController, CategoryDetailDelegate {
    
    var category: Results<Category>?
    let realm = try! Realm()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let category = category, category.count > 0 {
            tableView.reloadData()

        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        category = realm.objects(Category.self)
        if let category = category, category.count > 0 {
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let category = category {
            return category.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCategories", for: indexPath) as! ShowAllCategorysTableViewCell
        if let category = category {
            cell.textLabel?.text = category[indexPath.row].title
        }
        
        return cell
        
        
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let category = category {
            let newCategory = category[indexPath.row]
            performSegue(withIdentifier: "editCategory", sender: newCategory)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCategory" {
            if let navigationController = segue.destination as? UINavigationController, let destination = navigationController.topViewController as? DetailCategoryTableViewController {
                if let category = sender as? Category {
                    destination.category = category
                    
                }
                destination.editLabel = "Edit the Category:"
                destination.title = "Edit Category"
                destination.delegate = self
            }
        }
        
        if segue.identifier == "addCategory" {
            if let navigationController = segue.destination as? UINavigationController, let destination = navigationController.topViewController as? DetailCategoryTableViewController {
                destination.delegate = self
                destination.title = "Add Category"
                destination.editLabel = "Add a Category:"
            }
        }
    }
    
    func detailViewDidCancel(_ controller: UIViewController) {
        if let detailVC = controller as? DetailCategoryTableViewController {
            detailVC.dismiss(animated: true, completion: nil)
        }
    }
    
    func detailView(_ controller: UIViewController, didFinishAdding category: Category) {
        if let detailVC = controller as? DetailCategoryTableViewController {
            try! realm.write {
                realm.add(category)
            }
            detailVC.dismiss(animated: true, completion: {
                self.tableView.reloadData()
            })
        }
    }
    func detailView(_ controller: UIViewController, didFinishEditing category: Category) {
        if let detailVC = controller as? DetailCategoryTableViewController {
            try! realm.write {
                realm.add(category, update: true)
            }
            detailVC.dismiss(animated: true, completion: {
                self.tableView.reloadData()
            })
        }
    }
}
