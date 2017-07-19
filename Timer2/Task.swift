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
    var title: String
    var elapsed: Int = 0
    var max: Int
    var timer: Timer = Timer()
    var timerIsRunning = false
    var color: UIColor

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
    }
    
    @objc func tick() {
        viewController.tick(timer: timer)
    }
    
    func format(_ seconds: Int) -> String {
        let hour = seconds / 3600
        let minute = seconds / 60 % 60
        let second = seconds % 60
        
        return String(format: "%01i:%02i:%02i", hour, minute, second)
    }
    
    // implements Equatable protocol
    static func ==(a: Task, b: Task) -> Bool {
        return a === b
    }
    
}
