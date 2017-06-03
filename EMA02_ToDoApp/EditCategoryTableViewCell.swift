//
//  editCategoryTableViewCell.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 28.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//  DISCLAIMER THIS FILE IS A WORKING DRAFT
//

import UIKit
import RealmSwift

class EditCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryTextfield: UITextField!
    //private var categoryTitle: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /*
     für übergebene zelle
     alles kategorien aus datenbank lesen
     
     
     */
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
}
