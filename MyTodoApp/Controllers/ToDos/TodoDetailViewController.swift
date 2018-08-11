//
//  TodoDetailViewController.swift
//  MyTodoApp
//
//  Created by Guest User on 7/21/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TodoDetailViewController: UIViewController {
    
    var todo: ToDo?
    var isExisted = false

    @IBOutlet weak var titleTodoTextField: UITextField!
    @IBOutlet weak var descriptionTodoTextView: UITextView!
    @IBOutlet weak var todoActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo{
            titleTodoTextField.text = todo.title
            descriptionTodoTextView.text = todo.description
        }
        if !isExisted{
            todoActionButton.setTitle("Create", for: .normal)
            todoActionButton.addTarget(self, action: #selector(createTodo), for: .touchUpInside)
        }else{
            todoActionButton.setTitle("Save Changes", for: .normal)
            todoActionButton.addTarget(self, action: #selector(saveTodosChanges), for: .touchUpInside)
        }
        
    }
    
    @objc func createTodo(){
        let newTodo = ToDo(title: titleTodoTextField.text!, description: descriptionTodoTextView.text!, isTasksAvailable: false, creation: Date(), id: 0)
        TodoEndPoint.createTodo(withTodo: newTodo) { (idNewTodo, error) in
            if let error = error{
                print(error)
                return
            }
            if let _ = idNewTodo{
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }

    @objc func saveTodosChanges(){
        if let todo = self.todo{
            todo.title = titleTodoTextField.text!
            todo.description = descriptionTodoTextView.text!
            saveTodosChangesWith(todo: todo)
        }
     
    }
    
    func saveTodosChangesWith(todo: ToDo){
        TodoEndPoint.editTodo(withUpdatedTodo: todo){ (todoId, error) in
            if let error = error{
                print(error)
                return
            }
            if let _ = todoId{
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }

    
}
