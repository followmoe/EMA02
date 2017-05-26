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

    dynamic internal var title = ""
    convenience init(title: String) {
        self.init()
        self.title = title
    }

}
