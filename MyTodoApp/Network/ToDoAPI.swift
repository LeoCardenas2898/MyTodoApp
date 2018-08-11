//
//  ToDoAPI.swift
//  MyTodoApp
//
//  Created by Guest User on 7/28/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

class ToDoAPI {
    
    //%@ recibirá un String
    static let baseURL = "http://192.168.1.29:3000"
    static let myTodosUrl = "/api/ToDos"
    static let modifyMyTodoUrl = "/api/ToDos/%@"
    static let todoTaskUrl = "/api/ToDos/%@/tasks"
    static let myTasksUrl = "/api/Tasks"
}
