//
//  TaskDetailViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 08.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit

@objc protocol TaskViewDelegate{
    
    @objc optional func detailView(_ controller: UIViewController, didFinishEditing task: Task)
    
    @objc optional func detailView(_ controller: UIViewController, didFinishAdding task: Task)
    
    func detailViewDidCancel(_ controller: UIViewController)
    
    
}

class TaskDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var categorys = ["Job", "Privat", "Freizeit", "Banking", "Einkauf"]
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
        
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*-----------------------Navigation Buttons Functions----------------------*/
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        //TODO:
        //Wenn done tapped dann soll der neue Textfield text der neue Taskname sein.
        if let textFieldText = editTaskTextField.text{
            if textFieldText.characters.count > 0 {
                detailTask.title = textFieldText
            }
            delegate?.detailView!(self, didFinishEditing: detailTask)
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        print(detailTask.index)
        
        self.delegate?.detailViewDidCancel(self)
    }
    
    /*-----------------------PickerView-----------------------------*/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorys[row]
    }
    /*---------------------------- Edn of PickerView Implementation-------------------------------------*/
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
