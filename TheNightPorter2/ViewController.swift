//
//  ViewController.swift
//  TheNightPorter2
//
//  Created by Yang Lu on 2/18/18.
//  Copyright © 2018 7. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView:UITableView!
    
    // create task arrays
    var dailyTasks = [
        Task(name: "Check all windows", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Check all doors", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Is the boiler fueled?", type: .daily, completed: false, lastCompleted:nil),
        Task(name: "Check the mailbox", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Empty trash containers", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "If freezing, check water pipes", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Document \"strange and unusal\" occurrences", type: .daily, completed: false, lastCompleted: nil)
    ]
    
    var weeklyTasks = [
        Task(name: "Check inside all cabins", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Flush all lavatories in cabins", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Walk the periment of property", type: .weekly, completed: false, lastCompleted: nil)
    ]
    
    var twoWeekTasks = [
        Task(name: "Test security alarm", type: .monthly, completed: false, lastCompleted: nil),
        Task(name: "Test motion detectors", type: .monthly, completed: false, lastCompleted: nil),
        Task(name: "Test smoke alarm", type: .monthly, completed: false, lastCompleted: nil)
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title:"Complete"){
            (action: UIContextualAction, sourceView: UIView, actionPerformed:(Bool) -> Void) in
            
            // find the right object and set it to completed
            switch indexPath.section{
            case 0:
                self.dailyTasks[indexPath.row].completed = true
            case 1:
                self.weeklyTasks[indexPath.row].completed = true
            case 2:
                self.twoWeekTasks[indexPath.row].completed = true
            default:
                break
            }
            
            tableView.reloadData()
            
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions:[completeAction])
    }
    
    @IBAction func toggleDarkSwitch(_ sender: Any) {
        let mySwitch = sender as! UISwitch
        
        if mySwitch.isOn{
            view.backgroundColor = UIColor.darkGray
        }else{
            view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func resetList(_ sender: Any){
        
        let confirm = UIAlertController(title: "Are you Sure?",
                                        message: "Really reset the list?",
                                        preferredStyle:.alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive){
            action in
            
            for i in 0..<self.dailyTasks.count {
                self.dailyTasks[i].completed = false
            }
            
            for i in 0..<self.weeklyTasks.count{
                self.weeklyTasks[i].completed = false
            }
            
            for i in 0..<self.twoWeekTasks.count{
                self.twoWeekTasks[i].completed = false
            }
            
            self.taskTableView.reloadData()
        }
        
        let noAction = UIAlertAction(title:"No", style:.cancel){
            action in
            print("That was a close on!")
        }
        
        // add actions to alert controller
        confirm.addAction(yesAction)
        confirm.addAction(noAction)
        
        // show it
        present(confirm, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return dailyTasks.count
        case 1:
            return weeklyTasks.count
        case 2:
            return twoWeekTasks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var currentTask: Task!
        switch indexPath.section{
        case 0:
            currentTask = dailyTasks[indexPath.row]
        case 1:
            currentTask = weeklyTasks[indexPath.row]
        case 2:
            currentTask = twoWeekTasks[indexPath.row]
        default:
            break
        }
        
        cell.textLabel!.text = currentTask.name
        cell.backgroundColor = UIColor.clear
        
        if currentTask.completed {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        }else{
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section{
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Every two weeks"
        default:
            return "This should not be here"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row: \(indexPath.row) in section: \(indexPath.section)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



