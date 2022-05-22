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
        let tasks = [Task(status: .planned, priority: .important, title: "first task"), Task(status: .planned, priority: .important, title: "Second task"), Task(status: .planned, priority: .important, title: "Third task"), Task(status: .planned, priority: .normal, title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса"), Task(status: .planned, priority: .normal, title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса1"), Task(status: .planned, priority: .normal, title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса2"), Task(status: .planned, priority: .normal, title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса3"), Task(status: .planned, priority: .normal, title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса4")]
        return tasks
    }
    
      func save(_ tasks: [TaskProtocol]) {
        print("later bro")
    }
    
    
    
}
