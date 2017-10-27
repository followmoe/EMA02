//
//  ManageCategorysTableViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 28.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

class ManageCategorysTableViewController: UITableViewController {
   
    var category: Results<Category>!
    
    enum TableViewSections: Int {
        case editCategory =  0,
        showCategory = 1
    }
    var categorys = [Category]()
    
    var sec1 = Category(title: "No Category")
    var sec2 = Category(title: "Einkaufen")
    var sec3 = Category(title: "Beruf")
    var sec4 = Category(title: "Studium")
    var sec5 = Category(title: "Privat")
    var sec6 = Category(title: "Hobby")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EditCategoryTableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "editCategory")
        categorys.append(sec1)
        categorys.append(sec2)
        categorys.append(sec3)
        categorys.append(sec4)
        categorys.append(sec5)
        categorys.append(sec6)
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case TableViewSections.editCategory.rawValue:
            return 1
        case TableViewSections.showCategory.rawValue:
            return categorys.count // category.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case TableViewSections.editCategory.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCategory", for: indexPath) as! EditCategoryTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        case TableViewSections.showCategory.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "showAllSections", for: indexPath)
            cell.textLabel?.text = categorys[indexPath.row].title // category[indexPath.row].title
            return cell
        default:
            return UITableViewCell()
        }
        
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section == TableViewSections.showCategory.rawValue else {
            return false
        }
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == TableViewSections.showCategory.rawValue {
            // query database for the titel of the cell and set label in first section to the cell title
            let cell = tableView.cellForRow(at: indexPath) as! EditCategoryTableViewCell
            let text = cell.textLabel?.text
            let categoryTitle = category.filter("title = %@", text!)
            cell.updateUI(newText: (categoryTitle.first?.title)!)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case TableViewSections.editCategory.rawValue:
            return "Create or Edit Category:"
        case TableViewSections.showCategory.rawValue:
            return "Show all Categorys:"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == TableViewSections.editCategory.rawValue {
            return 2
        } else {
            return 20.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == TableViewSections.editCategory.rawValue {
            return 50.0
        } else {
            return 25.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == TableViewSections.editCategory.rawValue {
            return 100
        }else {
            return tableView.rowHeight
        }
        
    }
    
    
}
