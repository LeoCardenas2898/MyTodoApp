//
//  ToDoViewController.swift
//  MyTodoApp
//
//  Created by Guest User on 7/7/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var ToDoTableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ToDoViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .blue
        return refreshControl
    }()
    var todos: [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.register(UINib(nibName: "TodosTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
        ToDoTableView.addSubview(refreshControl)
        //ToDoTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData(refreshControl: nil)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl){
        getData(refreshControl: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(refreshControl: UIRefreshControl?){
        TodoEndPoint.getTodos { (todos, error) in
            guard error == nil, let todos = todos else{
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.todos = todos
                self.ToDoTableView.reloadData()
                refreshControl?.endRefreshing()
            }
        }
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier == "todoDetail" , let todo = sender as? ToDo {
            let todoDetailVC = storyboard!.instantiateViewController(withIdentifier: "todoDetailVC") as! TodoDetailViewController
            todoDetailVC.todo = todo
            todoDetailVC.isExisted = true
            //Pone un viewController encima
            self.navigationController?.pushViewController(todoDetailVC, animated: true)
            
        }
    }
    
}

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "todoDetail", sender: todo)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let todoDeleted = self.todos.remove(at: indexPath.row)
            self.ToDoTableView.deleteRows(at: [indexPath], with: .automatic)
        
        TodoEndPoint.delete(Todo: todoDeleted) { (itemsDeleted, error) in
            if let error = error{
                print(error)
            }
            //ToDo Show
            }
        }
    }
    
}


extension ToDoViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodosTableViewCell
        cell.titleLabel.text = todos[indexPath.row].title
        cell.descriptionLabel.text = todos[indexPath.row].description
        cell.creationLabel.text = "\(todos[indexPath.row].creation)"
        return cell
    }
    
    
}
