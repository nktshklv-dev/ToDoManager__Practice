//
//  TaskStorage.swift
//  ToDoManager__PRACTICE
//
//  Created by Nikita  on 5/20/22.
//

import Foundation


protocol TaskStorageProtocol{
    func load() -> [TaskProtocol]
    func save(_ tasks: [TaskProtocol])
}

class TaskStorage: TaskStorageProtocol{
    func load() -> [TaskProtocol] {
        let tasks = [Task(status: .planned, proiority: .normal, title: "first task"), Task(status: .planned, proiority: .important, title: "Second task"), Task(status: .planned, proiority: .important, title: "Third task"), Task(status: .completed, proiority: .normal, title: "Fourth task")]
        return tasks
    }
    
    func save(_ tasks: [TaskProtocol]) {
        print("later bro")
    }
    
    
    
}
