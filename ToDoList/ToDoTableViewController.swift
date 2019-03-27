//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Getu Gebre on 3/26/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit
class ToDoTableViewController: UITableViewController{
    var todos = [ToDo]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") else {
            fatalError("Could not dequeue a cell")
        }
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
}
