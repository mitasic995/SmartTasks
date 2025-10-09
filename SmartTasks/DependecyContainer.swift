//
//  DependecyContainer.swift
//  SmartTasks
//
//  Created by Milos Tasic on 7. 10. 2025..
//

import Foundation

final class DependencyContainer {
    let tasksService = TasksService(httpClient: URLSession.shared)
    let taskScheduler = TaskScheduler.self
}
