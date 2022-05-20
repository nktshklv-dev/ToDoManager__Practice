//
//  TripsViewController.swift
//  ToDoManager__PRACTICE
//
//  Created by Nikita  on 5/20/22.
//

import UIKit

class TripsViewController: UITableViewController {
    
    var tasks: [TaskPriority: [TaskProtocol]] = [:]
    var tasksStorage = TaskStorage()
    var sectionsForPriority: [TaskPriority] = [.important, .normal ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
        
    }
    private func loadTasks(){
        sectionsForPriority.forEach{
            type in tasks[type] = []
        }
        
        tasksStorage.load().forEach{
            task in tasks[task.priority]?.append(task)
        }
        
        for (taskPriority, tasksGroup) in tasks{
            tasks[taskPriority] = tasksGroup.sorted{
                task1, task2 in task1.status.rawValue < task2.status.rawValue
            }
        }
       
            
        
       
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = tasks[sectionsForPriority[section]] else{
            return 0
        }
        return section.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        
        let priority = sectionsForPriority[indexPath.section]
        guard let currentTask = tasks[priority]?[indexPath.row] else{
            return cell
        }
        
        cell.title.text = currentTask.title
        cell.icon.text = getIcon(currentTask.status)
        
        if currentTask.status == .planned{
            cell.title.textColor = .black
            cell.icon.textColor = .black
        }
        else if currentTask.status == .completed{
            cell.title.textColor = .lightGray
            cell.icon.textColor = .lightGray
        }
        
        return cell
    }
    
    private func getIcon(_ status: TaskStatus) -> String{
        var returnValue: String = ""
        if status == .completed{
            returnValue = "\u{25C9}"
        }
        else if status == .planned{
            returnValue = "\u{25CB}"
        }
        return returnValue
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String = ""
        if sectionsForPriority[section] == .important{
            title = "Important"
        }
        else if sectionsForPriority[section] == .normal{
            title = "Normal"
        }
        return title
    }
}
