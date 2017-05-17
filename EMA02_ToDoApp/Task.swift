//
//  Task.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 20.04.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import Foundation
import RealmSwift


class Task: Object{
    
    
    dynamic internal var _title: String?
    dynamic internal var _checked = false
    
    convenience init(title: String) {
        self.init()
        self._title = title
    }
    var title: String{
        return _title!
    }
    var checked: Bool{
        get{
            return _checked
        }
        set{
            return _checked = newValue
        }
    }
}
