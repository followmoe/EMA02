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
    
    var sections = [Sections]()
    
    var sec1 = Sections(title: "No Category")
    var sec2 = Sections(title: "Einkaufen")
    var sec3 = Sections(title: "Beruf")
    var sec4 = Sections(title: "Studium")
    var sec5 = Sections(title: "Privat")
    var sec6 = Sections(title: "Hobby")
    
    var delegate: TaskViewDelegate?
    

    private var category = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCategoryPickerView.delegate = self
        newCategoryPickerView.dataSource = self
        sections.append(sec1)
        sections.append(sec2)
        sections.append(sec3)
        sections.append(sec4)
        sections.append(sec5)
        sections.append(sec6)
        
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
        
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row].title
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = sections[row].title
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
