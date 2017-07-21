//
//  Task.swift
//  Timer2
//
//  Created by Alfred Wu on 7/15/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import UIKit

class Task: Equatable {
    
    var viewController: TimerListTableViewController
    var detailViewController: TimerDetailViewController?
    var title: String
    var elapsed: Int {
        if let startDate = startDate {
            if let pauseDate = pauseDate {
                return Int(pauseDate.timeIntervalSince1970 - startDate.timeIntervalSince1970) + adjustment
            } else {
                return Int(-startDate.timeIntervalSinceNow) + adjustment
            }
        } else {
            return adjustment
        }
    }
    var max: Int
    var adjustment: Int = 0
    var timer: Timer = Timer()
    var timerIsRunning = false
    var color: UIColor
    var startDate: Date?
    var pauseDate: Date?

    init(title: String, max: Int, color: UIColor, _ viewController: TimerListTableViewController) {
        self.title = title
        self.max = max * 60
        self.color = color
        self.viewController = viewController
    }
    
    var startButtonText: String {
        if timerIsRunning {
            return "Pause"
        } else {
            if elapsed == 0 {
                return "Start"
            } else {
                return "Resume"
            }
        }
    }
    
    var elapsedFormatted: String {
        return format(elapsed)
    }
    
    var maxFormatted: String {
        return format(max)
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Task.tick), userInfo: self, repeats: true)
        
        if let _ = pauseDate {
            startDate = Date() - TimeInterval(elapsed - adjustment)
        } else {
            startDate = Date()
        }
    }
    
    @objc func tick() {
        viewController.tick(timer: timer)
        if let detailViewController = detailViewController {
            detailViewController.tick()
        }
    }
    
    // implements Equatable protocol
    static func ==(a: Task, b: Task) -> Bool {
        return a === b
    }
    
}
