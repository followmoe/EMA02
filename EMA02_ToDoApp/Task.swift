//
//  Task.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 20.04.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    dynamic var taskId = NSUUID().uuidString
    dynamic internal var title = ""
    dynamic internal var checked = false
    dynamic internal var category = ""
    
    dynamic var index = 0
    
    convenience init(title: String, category: String) {
        self.init()
        self.title = title
        self.category = category
    }
    
    override class func primaryKey() -> String? {
        return "taskId"
    }
}
