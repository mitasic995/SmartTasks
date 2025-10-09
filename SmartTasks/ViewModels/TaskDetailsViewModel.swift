//
//  TaskDetailsViewModel.swift
//  SmartTasks
//
//  Created by Milos Tasic on 9. 10. 2025..
//

import Foundation

final class TaskDetailsViewModel: ObservableObject {
    struct Actions {
        let resolveTask: (String) async -> Bool
        let cantResolveTask: (String) async -> Bool
        let tasksStatus: (String) async -> SmartTask.Status
    }
    
    @Published var task: SmartTask
    let actions: TaskDetailsViewModel.Actions
    
    var isTaskResolved: Bool {
        task.status == .resolved
    }
    
    var isTaskUnresolved: Bool {
        task.status == .unresolved
    }
    
    init(task: SmartTask, actions: TaskDetailsViewModel.Actions) {
        self.task = task
        self.actions = actions
    }
    
    @MainActor
    func resolveTask() async {
        guard await actions.resolveTask(task.id) else { return }
        task.status = .resolved
    }
    
    @MainActor
    func cantResolveTask() async{
        guard await actions.cantResolveTask(task.id) else { return }
        task.status = .cantResolve
    }
    
    @MainActor
    func updateTaskStatus() async {
        let status = await actions.tasksStatus(task.id)
        task.status = status
    }
}
