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
            sum += task.elapsed
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
        
        tasks = [
            Task(title: "Studying", max: 65, color: .init(red: 0.5, green: 0.25, blue: 0.8, alpha: 0.5), self),
            Task(title: "Programming", max: 205, color: .init(red: 1, green: 0.5, blue: 0, alpha: 0.5), self),
            Task(title: "R&D", max: 30, color: .init(red: 0, green: 1, blue: 0, alpha: 0.5), self)
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tick(timer: Timer) {
        
        let task = timer.userInfo as! Task
        task.elapsed += 1
        
        let indexPath = IndexPath(row: tasks.index(of: task)!, section: 0)
        
        self.tableView.reloadRows(at: [indexPath], with: .none)
        aggregateLabel.
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
        
        return cell
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