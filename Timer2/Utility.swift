//
//  Utility.swift
//  Timer2
//
//  Created by Alfred Wu on 7/19/17.
//  Copyright © 2017 Alfred Wu. All rights reserved.
//

import Foundation


public func format(_ seconds: Int) -> String {
    let hour = seconds / 3600
    let minute = seconds / 60 % 60
    let second = seconds % 60
    
    return String(format: "%01i:%02i:%02i", hour, minute, second)
}

