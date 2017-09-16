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
    enum tableViewSections: Int {
        case editCategory =  0,
        createCategory = 1,
        showCategory = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func canceButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case tableViewSections.editCategory.rawValue:
            return configureCell(with: tableView, with: indexPath)
        case tableViewSections.createCategory.rawValue:
            return configureCell(with: tableView, with: indexPath)
        case tableViewSections.showCategory.rawValue:
            return configureCell(with: tableView, with: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
//    keeping the code clear in cellForRowAt:indexPath:
    func configureCell(with tableView: UITableView, with indexPath: IndexPath)-> UITableViewCell{
        
        switch indexPath.section {
        case tableViewSections.editCategory.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCategory", for: indexPath) as! EditCategoryTableViewCell
            return cell
        case tableViewSections.createCategory.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewCategory", for: indexPath)
            return cell
        case tableViewSections.showCategory.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "showAllSections", for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
        
    }

    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section == tableViewSections.showCategory.rawValue else {
            return false
        }
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == tableViewSections.showCategory.rawValue else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case tableViewSections.editCategory.rawValue:
            return "Create or Edit Category:"
        case tableViewSections.showCategory.rawValue:
            return "Show all Categorys:"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == tableViewSections.editCategory.rawValue{
            return 2
        }else{
            return 20.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == tableViewSections.createCategory.rawValue{
            return 5
        }else if section == tableViewSections.editCategory.rawValue{
            return 50.0
        }else {
            return 25.0
        }
    }
    
    /*
     ################### Funktions for filtering objects!! Two Versions which are doing the same! Work in Progress!
     
     
     func filterForExsistingObject(for cell: EditCategoryTableViewCell){
     if let realm = try? Realm(), let title = self.categoryTitle, let category = realm.object(ofType: Category.self, forPrimaryKey: title) {
     
     let exisitingCategorytitle = realm.objects(Category.self).filter("MATCHES %@", category.title)
     
     if exisitingCategorytitle.count > 0 {
     
     cell.categoryTextfield.text = category.title
     
     try! realm.write {
     category.title = cell.categoryTextfield.text!
     }
     
     }else{
     try! realm.write {
     realm.add(category)
     }
     }
     
     
     }
     }
     func filterObjects(with category: Category, for cell: UITableViewCell){
     if let realm = try? Realm(){
     let key = category.title
     let fetchedCategoryObject = realm.object(ofType: Category.self, forPrimaryKey: key)
     //            let filteredTitles = realm.objects(Category.self).filter("key MATCHES %@", "")
     if let categoryTitle = fetchedCategoryObject?.title {
     try! realm.write {
     category.title = categoryTitle
     }
     let editCell = cell as? EditCategoryTableViewCell
     editCell?.categoryTextfield.text = category.title
     }else{
     try! realm.write {
     realm.add(category)
     }
     }
     }
     }
     */
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
