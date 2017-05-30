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
    
    
//    temporary array until category tableview works!
    var categorys = [Category]()
    
    var sec1 = Category(title: "No Category")
    var sec2 = Category(title: "Einkaufen")
    var sec3 = Category(title: "Beruf")
    var sec4 = Category(title: "Studium")
    var sec5 = Category(title: "Privat")
    var sec6 = Category(title: "Hobby")
    
    var delegate: TaskViewDelegate?
    

    private var category = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCategoryPickerView.delegate = self
        newCategoryPickerView.dataSource = self
        categorys.append(sec1)
        categorys.append(sec2)
        categorys.append(sec3)
        categorys.append(sec4)
        categorys.append(sec5)
        categorys.append(sec6)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newTaskTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*-------------------------------Bar Button Items-------------------------------------*/
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        //check if textfield text is set
        if let newText = newTaskTextField.text {
            let addNewTask = Task(title: newText, category: category)
            delegate?.detailView!(self, didFinishAdding: addNewTask)
        }
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
        
        return categorys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorys[row].title
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = categorys[row].title
        if title == "No Category"{
            category = ""
        }else{
            category = title
        }
        
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
