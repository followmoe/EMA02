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
    
    
    dynamic internal var _title = ""
    dynamic internal var _checked = false
    
    convenience init(title: String) {
        self.init()
        self._title = title
    }
    var title: String{
        get{
            return _title
        }
        set{
            return _title = newValue
        }
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
