//
//  ToDo.swift
//  ToDoList
//
//  Created by Getu Gebre on 3/26/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import Foundation
struct ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]{
        return []
    }
    static func loadSampleToDos() -> [ToDo]{
        let todo1 = ToDo(title: "ToDo one", isComplete: false, dueDate: Date(), notes: "Note 1")
        let todo2 = ToDo(title: "Todo two", isComplete: false, dueDate: Date(), notes: "Note 2")
        let todo3 = ToDo(title: "ToDo three", isComplete: false, dueDate: Date(), notes: "Note 3")
        return [todo1, todo2, todo3]
    }
}
