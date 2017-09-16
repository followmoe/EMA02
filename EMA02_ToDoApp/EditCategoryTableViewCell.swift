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
    
}
