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
    var tasks: [Task] = []

    @IBOutlet weak var titleTodoTextField: UITextField!
    @IBOutlet weak var descriptionTodoTextView: UITextView!
    @IBOutlet weak var todoActionButton: UIButton!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var allowTasksSwitch: UISwitch!
    @IBOutlet weak var addNewTaskButton: UIButton!
    @IBOutlet weak var tasksTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo{
            titleTodoTextField.text = todo.title
            descriptionTodoTextView.text = todo.description
            TodoEndPoint.getTasksFrom(Todo: todo) {(tasks, error) in
                if let error = error{
                    print(error)
                }
                if let tasks = tasks, tasks.count > 0 {
                    //Llamando al hilo principal
                    DispatchQueue.main.async {
                        self.tasks = tasks
                        self.tasksTableView.reloadData()
                        self.allowTasksSwitch.setOn(true, animated: true)
                        self.allowTasksAction(self.allowTasksSwitch)
                        
                    }
                }
            }
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

    
    @IBAction func allowTasksAction(_ sender: UISwitch) {
        if sender.isOn{
            taskTextField.isHidden = false
            addNewTaskButton.isHidden = false
            tasksTableView.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
                self.taskTextField.alpha = 1
                self.addNewTaskButton.alpha = 1
                self.tasksTableView.alpha = 1
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
                self.taskTextField.alpha = 0
                self.addNewTaskButton.alpha = 0
                self.tasksTableView.alpha = 0
            }, completion: { _ in
                self.taskTextField.isHidden = true
                self.addNewTaskButton.isHidden = true
                self.tasksTableView.isHidden = true
            })
        }
    }
    
    @IBAction func addNewTaskAction(_ sender: UIButton) {
        guard !taskTextField.text!.isEmpty else{
            return
        }
        guard let todo = self.todo else{
            return
        }
        sender.isEnabled = false
        tasks.append(Task(title: taskTextField.text!, id: todo.id))
        tasksTableView.reloadData()
        
        TodoEndPoint.createTask(Title: taskTextField.text!, fromTodo: todo) { (idTask, error) in
            sender.isEnabled = true
            if let error = error{
                print(error)
            }
            if let _ = idTask{
                DispatchQueue.main.async {
                    self.taskTextField.text=""
                    self.taskTextField.resignFirstResponder()
                }
            }
        }
    }
    
}

extension TodoDetailViewController: UITableViewDelegate{
    
}

extension TodoDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].title
        return cell
    }
    
    
}
