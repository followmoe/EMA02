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
    
    func detailViewDidCancel(_ controller: UIViewController, identifier: String)
    
    
}

class TaskDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var sections = [Sections]()
    
    var sec1 = Sections(title: "Einkaufen")
    var sec2 = Sections(title: "Beruf")
    var sec3 = Sections(title: "Studium")
    var sec4 = Sections(title: "Privat")
    var sec5 = Sections(title: "Hobby")

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
        sections.append(sec1)
        sections.append(sec2)
        sections.append(sec3)
        sections.append(sec4)
        sections.append(sec5)
        
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
        if let textFieldText = editTaskTextField.text{
            if textFieldText.characters.count > 0 {
                detailTask.title = textFieldText
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
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = sections[row].title
        detailTask.category = title
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
