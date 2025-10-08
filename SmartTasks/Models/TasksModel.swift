//
//  Tasks.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

struct TasksModel {
    let tasks: [TaskModel]
}

extension TasksModel: Decodable {}
