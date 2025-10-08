//
//  TasksProviding.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

protocol TasksProviding: Sendable {
    /// Fetch array of smart tasks.
    /// - Returns: Array of `TaskModel`
    func getTasks() async throws -> [TaskModel]
}
