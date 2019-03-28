//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Getu Gebre on 3/27/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit
@objc protocol ToDoCellDelegate: class{
    func checkmarkTapped(sender: ToDoCell)
}
class ToDoCell: UITableViewCell {
    var delegate: ToDoCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!

    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    }
//    func completeButtonTapped(sender: ToDoCell){
//        if let indexPath = tableView.indexPath(for: sender){
//            let todo = todos[indexPath.row]
//            todo.isComplete = !todo.isComplete
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//            ToDo.saveToDos(todos)
//        }
//    }
}
