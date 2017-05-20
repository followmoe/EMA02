//
//  Category.swift
//  EMA02_ToDoApp
//
//  Created by Moritz Müller on 20.04.17.
//  Copyright © 2017 Moritz Müller. All rights reserved.
//

import Foundation
import RealmSwift

class Sections: Object{

    dynamic internal var _sectionName = ""
    
    convenience init(sectionName: String) {
        self.init()
        self._sectionName = sectionName
    }
    
    var sectionName: String{
        get{
            return _sectionName
        }
        set{
            return _sectionName = newValue
        }
    
    }


}
