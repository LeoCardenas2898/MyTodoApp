//
//  ToDo.swift
//  MyTodoApp
//
//  Created by Guest User on 7/7/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import Foundation

class ToDo{
    var title: String
    var description: String
    var isTasksAvailable: Bool
    var creation: Date
    var tasks: [Task]?
    
    init(title: String, description: String, isTasksAvailable: Bool, creation: Date){
        self.title = title
        self.description = description
        self.isTasksAvailable = isTasksAvailable
        self.creation = creation
    }
}
