//
//  TasksViewModel.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import Foundation

@MainActor
class TasksViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var tasks: [TaskModel]
    
    private let tasksService: TasksProviding
    
    init(tasksService: TasksProviding) {
        self.tasksService = tasksService
        tasks = []
    }
    
    func fetchTasks() async {
        do {
            let tasks  = try await tasksService.tasks()
            
            self.tasks = tasks
        } catch {
            errorMessage = "Oops! There's some problem."
        }
    }
}
