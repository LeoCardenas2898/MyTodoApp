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
        }else{
            todoActionButton.setTitle("Save Changes", for: .normal)
            todoActionButton.addTarget(self, action: #selector(saveTodosChanges), for: .touchUpInside)
        }
        
    }

    @objc func saveTodosChanges(){
        if let todo = self.todo{
            todo.title = titleTodoTextField.text!
            todo.description = descriptionTodoTextView.text!
            saveTodosChangesToServerWith(todo: todo)
        }
     
    }
    
    func saveTodosChangesToServerWith(todo: ToDo){
        let params = ["title": todo.title, "description": todo.description ]
        let url = String(format: "\(ToDoAPI.baseURL)\(ToDoAPI.editMyTodoUrl)", "\(todo.id)")
        Alamofire.request(url, method: .put, parameters: params).responseJSON{ response in
            self.navigationController?.popViewController(animated: true)
        }
    }

    
}
