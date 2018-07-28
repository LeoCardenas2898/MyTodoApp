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
    var todos: [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.register(UINib(nibName: "TodosTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
        ToDoTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        Alamofire.request("\(ToDoAPI.baseURL)\(ToDoAPI.myTodosUrl)").responseJSON { response in
            switch(response.result){
            case .success:
                let data = JSON(response.data!)
                self.todos = ToDo.from(jsonArray: data.array!)
                self.ToDoTableView.reloadData()
                
            case .failure(let error):
                print(error)
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
