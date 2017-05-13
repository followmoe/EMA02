//
//  TaskDetailViewController.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 08.05.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskLabel: UILabel!
    private var _newText:Task?
    
    var newText:Task!{
        get{
            return _newText
        }
        set{
        _newText = newValue
        }
    }
    
    override func viewDidLoad() {
        if let newText = newText{
            taskLabel.text = newText.title
        }
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
