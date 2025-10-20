//
//  RemoteSourceMock.swift
//  SmartTasksTests
//
//  Created by Milos Tasic on 10. 10. 2025..
//

import Foundation
@testable import SmartTasks

actor RemoteSourceMock: TasksProviding {
    var getTasksCalled = false
    func getTasks() async throws -> [TaskModel] {
        getTasksCalled = true
        return [
            TaskModel(id: "1", targetDate: .now, dueDate: nil, title: "title", description: "desc", priority: 1)
        ]
    }
}

