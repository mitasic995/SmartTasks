//
//  TasksRepository.swift
//  SmartTasks
//
//  Created by Milos Tasic on 9. 10. 2025..
//

import Foundation

protocol TasksRepository: Sendable {
    /// Fetches taks
    func fetchTasks() async throws -> [TaskModel]
    func resolveTask(id: String) async -> Bool
    func cantResolveTask(id: String) async -> Bool
    func tasksStatus(id: String) async -> SmartTask.Status
}

private enum Keys {
    static let smartTasks = "smart-tasks"
    static let resolvedTasks = "resolved-tasks"
    static let cantResolvedTasks = "cant-resolved-tasks"
}

final class SmartTasksRepository: TasksRepository {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let localSource: LocalStoring
    private let remoteSource: TasksProviding
    
    init(localSource: LocalStoring, remoteSource: TasksProviding) {
        self.localSource = localSource
        self.remoteSource = remoteSource
    }
    
    func fetchTasks() async throws -> [TaskModel] {
        guard let data = await localSource.readFrom(Keys.smartTasks) else {
            let tasks = try await remoteSource.getTasks()
            // Save it locally
            await localSource.writeTo(Keys.smartTasks, data: try encoder.encode(tasks))
            return tasks
        }
        
        return try decoder.decode([TaskModel].self, from: data)
    }
    
    func resolveTask(id: String) async -> Bool {
        guard let data = try? encoder.encode(SmartTask.Status.resolved) else { return false }
        return await localSource.writeTo(id, data: data)
    }
    
    func cantResolveTask(id: String) async -> Bool {
        guard let data = try? encoder.encode(SmartTask.Status.cantResolve) else { return false }
        return await localSource.writeTo(id, data: data)
    }

    func tasksStatus(id: String) async -> SmartTask.Status {
        guard let data = await localSource.readFrom(id),
              let status = try? decoder.decode(SmartTask.Status.self, from: data) else {
            return .unresolved
        }

        return status
    }
}


