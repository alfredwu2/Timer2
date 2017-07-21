//
//  TimerTableViewCell.swift
//  Timer2
//
//  Created by Alfred Wu on 7/15/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {

    var viewController: TimerListTableViewController?
    var indexPath: IndexPath?
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setVC(_ viewController: TimerListTableViewController) {
        self.viewController = viewController
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if let task = viewController?.tasks[(indexPath?.row)!] {
            if task.timerIsRunning {
                task.timer.invalidate()
                task.timerIsRunning = false
                task.pauseDate = Date()
            } else {
                task.start()
                task.timerIsRunning = true
                task.pauseDate = nil
            }
        }
        
        // reload the table view row
        viewController?.tableView.reloadRows(at: [indexPath!], with: .none)
        viewController?.updateAggregateLabel()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        if let task = viewController?.tasks[(indexPath?.row)!] {
            task.startDate = nil
            task.pauseDate = nil
            task.timer.invalidate()
            task.timerIsRunning = false
            task.adjustment = 0
        }
        
        // reload the table view row
        viewController?.tableView.reloadRows(at: [indexPath!], with: .none)
        viewController?.updateAggregateLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
