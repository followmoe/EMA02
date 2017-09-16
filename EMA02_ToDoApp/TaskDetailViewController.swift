//
//  TaskDetailViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 08.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit
import RealmSwift

@objc protocol TaskViewDelegate{
    
    @objc optional func detailView(_ controller: UIViewController, didFinishEditing task: Task)
    
    @objc optional func detailView(_ controller: UIViewController, didFinishAdding task: Task)
    
    func detailViewDidCancel(_ controller: UIViewController, identifier: String)
    
    
}

class TaskDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var categorys = [Category]()
    
    var sec1 = Category(title: "No Category")
    var sec2 = Category(title: "Einkaufen")
    var sec3 = Category(title: "Beruf")
    var sec4 = Category(title: "Studium")
    var sec5 = Category(title: "Privat")
    var sec6 = Category(title: "Hobby")
    
    var delegate: TaskViewDelegate?
    private var _detailTask:Task!
    
    var detailTask:Task{
        get{
            return _detailTask
        }
        set{
            _detailTask = newValue
        }
    }
    
    override func viewDidLoad() {
        
        taskLabel.text = detailTask.title
        categorys.append(sec1)
        categorys.append(sec2)
        categorys.append(sec3)
        categorys.append(sec4)
        categorys.append(sec5)
        categorys.append(sec6)
        
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editTaskTextField.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*-----------------------Navigation Buttons Functions----------------------*/
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        if let textFieldText = editTaskTextField.text{
            if textFieldText.characters.count > 0 {
                try! realm.write {
                    detailTask.title = textFieldText
                }
                
            }
            delegate?.detailView!(self, didFinishEditing: detailTask)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
        let ident = identifier()
        let editTask = ident.editTask
        self.delegate?.detailViewDidCancel(self, identifier: editTask)
    }
    
    /*-----------------------PickerView-----------------------------*/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorys[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let realm = try! Realm()
        let title = categorys[row].title
        try! realm.write {
            if title == "No Category"{
                detailTask.category = ""
            }else{
                detailTask.category = title
                
            }
        }
        
        
    }
    /*---------------------------- End of PickerView Implementation-------------------------------------*/
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
