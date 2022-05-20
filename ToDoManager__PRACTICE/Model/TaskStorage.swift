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
        let tasks = [Task(status: .completed, priority: .important, title: "first task"), Task(status: .completed, priority: .important, title: "Second task"), Task(status: .planned, priority: .important, title: "Third task"), Task(status: .completed, priority: .normal, title: "Fourth task")]
        return tasks
    }
    
      func save(_ tasks: [TaskProtocol]) {
        print("later bro")
    }
    
    
    
}
