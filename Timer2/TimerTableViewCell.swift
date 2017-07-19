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
            } else {
                task.start()
                task.timerIsRunning = true
            }
        }
        
        // reload the table view row
        viewController?.tableView.reloadRows(at: [indexPath!], with: .none)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        if let task = viewController?.tasks[(indexPath?.row)!] {
            task.elapsed = 0
            task.timer.invalidate()
            task.timerIsRunning = false
        }
        
        // reload the table view row
        viewController?.tableView.reloadRows(at: [indexPath!], with: .none)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
