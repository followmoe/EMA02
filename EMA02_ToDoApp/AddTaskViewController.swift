//
//  AddTaskViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 20.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var newCategoryPickerView: UIPickerView!
    @IBOutlet weak var newTaskTextField: UITextField!
    
    var delegate: TaskViewDelegate?
    private var _addTask: Task?
    
    var addTask: Task{
        get{
            return _addTask!
        }
        set{
            return _addTask = newValue
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCategoryPickerView.delegate = self
        newCategoryPickerView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*-------------------------------Bar Button Items-------------------------------------*/
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        
        let newTask = Task()
        if let newText = newTaskTextField.text{
            newTask.title = newText
            newTask.checked = false
        }
        delegate?.detailView!(self, didFinishAdding: newTask)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        let ident = identifier()
        let addTask = ident.addTask
        delegate?.detailViewDidCancel(self, identifier: addTask)
    }
    
    /*------------------------------End Implementation of Bar Button Items---------------------------*/
    
    
    /*------------------------------------------Category PickerView-----------------------------------*/
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return sections.count
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return sections[row].sectionName
        return "Placeholder"
    }

    
    /*------------------------------End Implementation of Category PickerView-------------------------*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
