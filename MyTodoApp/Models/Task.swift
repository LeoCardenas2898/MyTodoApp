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
    var id : Int
    
    init(title: String, id: Int) {
        self.title = title
        self.id = id
    }
    
    static func from(json: JSON)-> Task{
        return Task(title: json["title"].stringValue, id: json["id"].intValue)
    }
    
    static func from(jsonArray: [JSON])-> [Task]{
        var resultArray: [Task] = []
        for jsonTask in jsonArray{
            resultArray.append(Task.from(json: jsonTask))
        }
        return resultArray
    }
    
}
