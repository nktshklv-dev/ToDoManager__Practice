//
//  TripsViewController.swift
//  ToDoManager__PRACTICE
//
//  Created by Nikita  on 5/20/22.
//

import UIKit

class TripsViewController: UITableViewController {
    //MARK: - variables
    var tasks: [TaskPriority: [TaskProtocol]] = [:]{
        didSet{
            for (taskPriority, tasksGroup) in tasks{
                tasks[taskPriority] = tasksGroup.sorted{
                    task1, task2 in task1.status.rawValue < task2.status.rawValue
                }
            }
        }
    }
    var tasksStorage = TaskStorage()
    var taskPriorityInSection: [TaskPriority] = [.important, .normal ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    //MARK: - load tasks
    private func loadTasks(){
        //for each type creating empty array
        taskPriorityInSection.forEach{
            type in tasks[type] = []
        }
        
        tasksStorage.load().forEach{
            task in tasks[task.priority]?.append(task)
        }
    }
    //MARK: - number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    //MARK: - number of rows in sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = tasks[taskPriorityInSection[section]] else{
            return 0
        }
        return section.count
        
    }

    //MARK: - cell for row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        
        let priority = taskPriorityInSection[indexPath.section]
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
    //MARK: - get icon
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

    //MARK: - title for header in section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String = ""
        if taskPriorityInSection[section] == .important{
            title = "Important"
        }
        else if taskPriorityInSection[section] == .normal{
            title = "Normal"
        }
        return title
    }
    
    //MARK: - did select row at
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskType = taskPriorityInSection[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else{
            return
        }
        
        guard tasks[taskType]![indexPath.row].status == .planned else{
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        tasks[taskType]![indexPath.row].status = .completed
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    //MARK: - leading swipe actions config
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let taskType = taskPriorityInSection[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else{
            return nil
        }
        
        guard tasks[taskType]![indexPath.row].status == .completed else{
            return nil
        }
        
        let action = UIContextualAction(style: .normal, title: "Plan", handler: {
            _,_,_ in self.tasks[taskType]![indexPath.row].status = .planned
            tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
    //MARK: - commit function(deleting)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = taskPriorityInSection[indexPath.section]
        tasks[taskType]?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    //MARK: - can move at
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //MARK: - move row at
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskTypeFrom = taskPriorityInSection[sourceIndexPath.section]
        let taskTypeTo = taskPriorityInSection[destinationIndexPath.section]
        
        guard let task = tasks[taskTypeFrom]?[sourceIndexPath.row] else{
            return
        }
        tasks[taskTypeFrom]?.remove(at: sourceIndexPath.row)
        tasks[taskTypeTo]?.insert(task, at: destinationIndexPath.row)
                
        if task.priority != taskTypeTo{
            tasks[taskTypeTo]?[destinationIndexPath.row].priority = taskTypeTo
            
        }
        tableView.reloadData()
                
        
    }
}
