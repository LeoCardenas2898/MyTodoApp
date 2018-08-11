//
//  TodoEndPoint.swift
//  MyTodoApp
//
//  Created by Usuario invitado on 11/8/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class TodoEndPoint{
    static func getTodos(completionHandler: @escaping(_ todos: [ToDo]? ,_ error: String?)-> Void){
        Alamofire.request("\(ToDoAPI.baseURL)\(ToDoAPI.myTodosUrl)").responseJSON{ response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                completionHandler(ToDo.from(jsonArray: data.array!), nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    static func editTodo(withUpdatedTodo updateTodo: ToDo, completionHandler: @escaping(_ idTodo: String?, _ error: String?)->Void){
        let url = String(format: "\(ToDoAPI.baseURL)\(ToDoAPI.modifyMyTodoUrl)", "\(updateTodo.id)")
        let params = ["title": updateTodo.title, "description": updateTodo.description]
        Alamofire.request(url, method: .put, parameters: params).responseJSON{ response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                completionHandler(data.dictionary!["id"]?.stringValue, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
            
        }
    }
    
    static func createTodo(withTodo todo: ToDo, completionHandler: @escaping(_ idTodo: String?, _ error: String?)->Void){
        let url = "\(ToDoAPI.baseURL)\(ToDoAPI.myTodosUrl)"
        let params = ["title": todo.title,
                      "description": todo.description,
                      "dataCreated": Date().description,
                      "dataUpdated": Date().description,
                      "isDeleted": true,
                      "toDoUserId": "0"] as [String: Any]
        Alamofire.request(url, method: .put, parameters: params).responseJSON{ response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                completionHandler(data.dictionary!["id"]?.stringValue, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, error.localizedDescription)
            }
        
        }
    }
    
    static func delete(Todo todo: ToDo, completionHandler: @escaping(_ idTodo: Int?, _ error: String?)->Void){
        let url = String(format: "\(ToDoAPI.baseURL)\(ToDoAPI.modifyMyTodoUrl)", "\(todo.id)")
        let params = ["id": todo.id]
        Alamofire.request(url, method: .delete, parameters: params).responseJSON { response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                completionHandler(data.dictionary!["count"]?.intValue, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil,error.localizedDescription)
            }
        }
    }
    
    static func getTasksFrom(Todo todo: ToDo, completionHandler: @escaping(_ tasks: [Task]?, _ error: String?)->Void){
        let url = String(format: "\(ToDoAPI.baseURL)\(ToDoAPI.todoTaskUrl)", "\(todo.id)")
        Alamofire.request(url).responseJSON { response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                completionHandler(Task.from(jsonArray: data.array!),nil)
            case .failure(let error):
                print(error)
                completionHandler(nil,error.localizedDescription)
            }
        }
    }
    
    static func createTask(Title title: String, fromTodo todo: ToDo, completionHandler: @escaping(_ idTask: Int?, _ error: String?)->Void){
        let url = "\(ToDoAPI.baseURL)\(ToDoAPI.myTasksUrl)"
        let params = ["title": title,
                      "isDone": false,
                      "toDoId": todo.id
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params).responseJSON { response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                completionHandler(data.dictionary!["id"]?.intValue, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil,error.localizedDescription)
            }
        }
    }
}
