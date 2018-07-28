//
//  Task.swift
//  MyTodoApp
//
//  Created by Guest User on 7/7/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import Foundation
import SwiftyJSON

class Task{
    var title: String
    var creation: Date
    
    init(title: String, creation: Date) {
        self.title = title
        self.creation = creation
    }
    
    static func from(json: JSON)-> Task{
        return Task(title: json["title"].stringValue, creation: Date())
    }
    
    static func from(jsonArray: [JSON])-> [Task]{
        var resultArray: [Task] = []
        for jsonTask in jsonArray{
            resultArray.append(Task.from(json: jsonTask))
        }
        return resultArray
    }
    
}
