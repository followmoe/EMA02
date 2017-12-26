//
//  TaskDetailViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 08.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

@objc protocol TaskViewDelegate {
    
    @objc optional func detailView(_ controller: UIViewController, didFinishEditing task: Task)
    
    @objc optional func detailView(_ controller: UIViewController, didFinishAdding task: Task)
    
    func detailViewDidCancel(_ controller: UIViewController)
}

class TaskDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var categorys: Results<Category>?
    var category = ""
    var controllerLabel: String?

    
    weak var delegate: TaskViewDelegate?
    var detailTask: Task?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        if let dtask = detailTask {
            editTaskTextField.text = dtask.title
        }
        categorys = realm.objects(Category.self)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editTaskTextField.becomeFirstResponder()
        if let text = controllerLabel {
           taskLabel.text = text
        }
        var i = 0
        if let categories = categorys {
            for category in categories {
                if category.title == self.category {
                    categoryPicker.selectRow(i, inComponent: 0, animated: false)
                }
                i += 1
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        if let textFieldText = editTaskTextField.text, let dtask = detailTask {
            if textFieldText.count > 0 {
                try! realm.write {
                    dtask.title = textFieldText
                }
            }
            delegate?.detailView!(self, didFinishEditing: dtask)
        }
        
        if let textFieldText = editTaskTextField.text, detailTask == nil {
            if textFieldText.count > 0 {
                let addNewTask = Task(title: textFieldText, category: category)
                delegate?.detailView!(self, didFinishAdding: addNewTask)
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
        self.delegate?.detailViewDidCancel(self)
        
    }
    
}
extension TaskDetailViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let categories = categorys {
            return categories.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let categories = categorys {
            return categories[row].title
        } else {
            return "No Category"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let categories = categorys {
            let title = categories[row].title
            try! realm.write {
                if let dtask = detailTask {
                        dtask.category = title
                }
            }
            if detailTask == nil {
                category = title
            }
        }
    }
}
