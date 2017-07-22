//
//  TimerListTableViewController.swift
//  Timer2
//
//  Created by Alfred Wu on 7/15/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class TimerListTableViewController: UITableViewController {

    
    
    @IBOutlet weak var aggregateLabel: UILabel!

    var tasks: [Task] = []
    var totalElapsed: Int {
        var sum = 0
        for task in tasks {
            if task.elapsed > task.max {
                sum += task.max
            } else {
                sum += task.elapsed
            }
        }
        
        return sum
    }
    var totalMax: Int {
        var sum = 0
        for task in tasks {
            sum += task.max
        }
        
        return sum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let alpha: CGFloat = 0.3
        
        tasks = [
            Task(title: "Studying", max: 70, color: .init(red: 0, green: 0, blue: 1, alpha: alpha), self),
            Task(title: "Programming", max: 210, color: .init(red: 1, green: 0.5, blue: 0, alpha: alpha), self),
            Task(title: "R&D", max: 30, color: .init(red: 0, green: 1, blue: 0, alpha: alpha), self),
            Task(title: "'Normal' practice", max: 30, color: .init(red: 0.3, green: 0.3, blue: 0.3, alpha: alpha), self),
            Task(title: "Journal", max: 20, color: .init(red: 1, green: 0, blue: 0, alpha: alpha), self),
            Task(title: "Art", max: 20, color: .init(red: 1, green: 0, blue: 1, alpha: alpha), self)
        ]

        updateAggregateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tick(timer: Timer) {
        
        let task = timer.userInfo as! Task
        
        let indexPath = IndexPath(row: tasks.index(of: task)!, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
        updateAggregateLabel()
        
    }
    
    func updateAggregateLabel() {
        aggregateLabel.text = "\(format(totalElapsed)) / \(format(totalMax))"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TimerTableViewCell
        
        let task = tasks[indexPath.row]
        
        // Configure the cell...
        cell.startButton.setTitle(task.startButtonText, for: .normal)
        cell.titleLabel.text = task.title
        cell.timerLabel.text = task.elapsedFormatted
        cell.maxLabel.text = "/ \(task.maxFormatted)"
        cell.indexPath = indexPath
        cell.setVC(self)
        cell.backgroundColor = task.color
        
        if task.elapsed > task.max {
            cell.titleLabel.textColor = UIColor.lightGray
            cell.timerLabel.textColor = UIColor.lightGray
            cell.maxLabel.textColor = UIColor.lightGray
        } else {
            cell.titleLabel.textColor = UIColor.black
            cell.timerLabel.textColor = UIColor.black
            cell.maxLabel.textColor = UIColor.black
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TimerDetailViewController
                
        if let row = tableView.indexPathForSelectedRow?.row {
            let task = tasks[row]
            task.detailViewController = destination
            destination.task = task
            destination.timerListTableViewController = self
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
