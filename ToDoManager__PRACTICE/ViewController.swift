//
//  ViewController.swift
//  ToDoManager__PRACTICE
//
//  Created by Nikita  on 5/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    var tasksStorage = TaskStorage()
    var tasks: [TaskPrioirity: [TaskProtocol]] = [:]
    var sectionsForPriority: [TaskPriority] = [.normal, .important]

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


}

