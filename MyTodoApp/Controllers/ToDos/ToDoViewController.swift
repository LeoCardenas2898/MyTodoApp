//
//  ToDoViewController.swift
//  MyTodoApp
//
//  Created by Guest User on 7/7/18.
//  Copyright © 2018 DoApps. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var ToDoTableView: UITableView!
    var todos: [ToDo] = [ToDo(title: "Lista de compras", description: "Ingredientes de la cena", isTasksAvailable: false, creation: Date())]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.register(UINib(nibName: "TodosTableViewCell", bundle: nil), forCellReuseIdentifier: "todoCell")
        ToDoTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
