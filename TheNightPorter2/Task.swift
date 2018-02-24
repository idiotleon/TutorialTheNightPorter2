//
//  Task.swift
//  TheNightPorter2
//
//  Created by Yang Lu on 2/23/18.
//  Copyright © 2018 7. All rights reserved.
//

import Foundation

enum TaskType{
    case daily, weekly, monthly
}

struct Task{
    var name: String
    var type: TaskType
    var completed: Bool
    var lastCompleted: NSDate?
}
