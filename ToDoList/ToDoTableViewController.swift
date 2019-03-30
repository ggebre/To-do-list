//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Getu Gebre on 3/26/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit
class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var todos = [ToDo]()
    
    var filteredTodos = [ToDo]()
    var searching = false
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender){
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ToDo.loadToDos().count != 0{
            todos = ToDo.loadToDos()
        } else {
            todos = ToDo.loadSampleToDos()
        }
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredTodos.count
        } else {
            return todos.count
        }
        
    }
    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier")as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        if searching{
            let ftodo = filteredTodos[indexPath.row]
            cell.titleLabel?.text = ftodo.title
            cell.isCompleteButton.isSelected = ftodo.isComplete
            cell.delegate = self
        } else {
            let todo = todos[indexPath.row]
            cell.titleLabel?.text = todo.title
            cell.isCompleteButton.isSelected = todo.isComplete
            cell.delegate = self
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        }
    }
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! ToDoViewController
        
        if let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
       ToDo.saveToDos(todos)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
    
    
}

extension ToDoTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTodos = todos.filter{$0.title.lowercased().contains(searchText.lowercased())}
        searching = true
        tableView.reloadData()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
