//
//  Tasks.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

/// DTO model of main endpoint response.
struct TasksModel {
    let tasks: [TaskModel]
}

extension TasksModel: Decodable {}
