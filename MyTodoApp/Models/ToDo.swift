//
//  ToDo.swift
//  MyTodoApp
//
//  Created by Guest User on 7/7/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import Foundation
import SwiftyJSON

class ToDo{
    var id: Int
    var title: String
    var description: String
    var isTasksAvailable: Bool
    var creation: Date
    var tasks: [Task]?
    
    init(title: String, description: String, isTasksAvailable: Bool, creation: Date, id: Int){
        self.title = title
        self.description = description
        self.isTasksAvailable = isTasksAvailable
        self.creation = creation
        self.id = id
    }
    
    static func from(json: JSON)-> ToDo{
        return ToDo(title: json["title"].stringValue,
                    description: json["description"].stringValue,
                    isTasksAvailable: json["isTasksAvailable"].boolValue,
                    creation: Date(), id: json["id"].intValue)
    }
    
    static func from(jsonArray: [JSON])-> [ToDo]{
        var resultArray: [ToDo] = []
        for jsonToDo in jsonArray{
            resultArray.append(ToDo.from(json: jsonToDo))
        }
        return resultArray
    }
}
