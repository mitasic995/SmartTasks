//
//  TasksProviding.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

protocol TasksProviding: Sendable {
    func tasks() async throws -> [TaskModel]
}
