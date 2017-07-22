//
//  TimerDetailViewController.swift
//  Timer2
//
//  Created by Alfred Wu on 7/20/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class TimerDetailViewController: UIViewController {

    @IBOutlet weak var elapsedLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var elapsedMinusButton: UIButton!
    @IBOutlet weak var elapsedPlusButton: UIButton!
    @IBOutlet weak var maxMinusButton: UIButton!
    @IBOutlet weak var maxPlusButton: UIButton!
    
    
    var timerListTableViewController: TimerListTableViewController?
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = task?.title
        tick()
    }
    
    func tick() {
        if let task = task {
            elapsedLabel.text = task.elapsedFormatted
            maxLabel.text = "/ \(task.maxFormatted)"
        }
    }
    
    @IBAction func elapsedMinusButtonTapped(_ sender: Any) {
        if let task = task {
            task.adjustment -= 60
        }
        tick()
        if let timerListTableViewController = timerListTableViewController {
            timerListTableViewController.tableView.reloadData()
            timerListTableViewController.updateAggregateLabel()
        }
    }
    
    @IBAction func elapsedPlusButtonTapped(_ sender: Any) {
        if let task = task {
            task.adjustment += 60
        }
        tick()
        if let timerListTableViewController = timerListTableViewController {
            timerListTableViewController.tableView.reloadData()
            timerListTableViewController.updateAggregateLabel()
        }
    }
    
    @IBAction func maxMinusButtonTapped(_ sender: Any) {
        if let task = task {
            task.max -= 60
        }
        tick()
        if let timerListTableViewController = timerListTableViewController {
            timerListTableViewController.tableView.reloadData()
            timerListTableViewController.updateAggregateLabel()
        }
    }
    
    @IBAction func maxPlusButtonTapped(_ sender: Any) {
        if let task = task {
            task.max += 60
        }
        tick()
        if let timerListTableViewController = timerListTableViewController {
            timerListTableViewController.tableView.reloadData()
            timerListTableViewController.updateAggregateLabel()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
