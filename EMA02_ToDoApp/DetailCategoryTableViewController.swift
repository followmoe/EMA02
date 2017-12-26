//
//  DetailCategoryTableViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 26.12.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

@objc protocol CategoryDetailDelegate {
    
    @objc optional func detailView(_ controller: UIViewController, didFinishEditing category: Category)
    
    @objc optional func detailView(_ controller: UIViewController, didFinishAdding category: Category)
    
    func detailViewDidCancel(_ controller: UIViewController)
}

class DetailCategoryTableViewController: UITableViewController {
    
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let realm = try! Realm()
    
    var category: Category?
    var editLabel: String?

    weak var delegate: CategoryDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let label = editLabel {
            categoryLabel.text = label
        }
        if let category = category {
            categoryTextField.text = category.title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return 2
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        delegate?.detailViewDidCancel(self)
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        if let text = categoryTextField.text, text.count > 0 && category == nil {
            let newCategory = Category(title: text)
            delegate?.detailView!(self, didFinishAdding: newCategory)
            
        }
        
        if let text = categoryTextField.text {
            if let category = category {
                try! realm.write {
                    category.title = text
                }
                delegate?.detailView!(self, didFinishEditing: category)
            }
        }
    }
    
    

}
