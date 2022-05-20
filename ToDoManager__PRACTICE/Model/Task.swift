//
//  Task.swift
//  ToDoManager__PRACTICE
//
//  Created by Nikita  on 5/20/22.
//

import Foundation



enum TaskPriority{
    case normal
    case important
}


enum TaskStatus: Int{
    case planned
    case completed
}

protocol TaskProtocol{
    var status: TaskStatus {get set}
    var priority: TaskPriority {get set}
    var title: String {get set}
}

struct Task: TaskProtocol{
    var status: TaskStatus
    
    var priority: TaskPriority
    
    var title: String
}



