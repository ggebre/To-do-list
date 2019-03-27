//
//  ToDo.swift
//  ToDoList
//
//  Created by Getu Gebre on 3/26/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import Foundation
struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]{
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else {return []}
        let propertyListDecoder = PropertyListDecoder()
        
        return try! propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    static func saveToDos(_ todos: [ToDo]){
        let propertyLIstEncoder = PropertyListEncoder()
        let codedToDos = try? propertyLIstEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
    static func loadSampleToDos() -> [ToDo]{
        let todo1 = ToDo(title: "ToDo one", isComplete: false, dueDate: Date(), notes: "Note 1")
        let todo2 = ToDo(title: "Todo two", isComplete: false, dueDate: Date(), notes: "Note 2")
        let todo3 = ToDo(title: "ToDo three", isComplete: false, dueDate: Date(), notes: "Note 3")
        return [todo1, todo2, todo3]
    }
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
}
