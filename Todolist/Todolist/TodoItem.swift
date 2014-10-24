//
//  TodoItem.swift
//  Todolist
//
//  Created by formation on 15/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import Foundation

class TodoItem {
    
    var name: String
    var completed : Bool = false
    var creationDate = NSDate()
    
    init(name: String) {
        self.name = name
    }
    
}