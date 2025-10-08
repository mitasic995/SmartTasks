//
//  TasksViewModel.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import Foundation

@MainActor
final class TasksViewModel: ObservableObject {
    @Published var title: String = "Today"
    @Published var errorMessage: String?
    @Published var smartTasks: [SmartTask] = []
    @Published private var selectedDate: Date {
        didSet {
            self.title = formatSelectedDate()
            let selectedTasks = schedule[selectedDate] ?? []
            self.smartTasks = selectedTasks.compactMap { [weak self] model in
                self?.convertToSmartTask(model)
            }
        }
    }
    
    private var schedule: [Date: [TaskModel]] = [:]
    private let tasksService: TasksProviding
    private let calendar: Calendar
    private var smartTaskFormatter: DateFormatter
    
    init(tasksService: TasksProviding) {
        self.selectedDate = TaskScheduler.today
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = .gmt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        self.smartTaskFormatter = formatter
        
        self.calendar = calendar
        self.tasksService = tasksService
    }
    
    func fetchTasks() async {
        do {
            let fetchedTasks  = try await tasksService.getTasks()
            self.schedule = TaskScheduler.scheduleTasks(fetchedTasks)
            let tasks = schedule[selectedDate] ?? []
            self.smartTasks = tasks.compactMap { [weak self] model in
                self?.convertToSmartTask(model)
            }
            
        } catch {
            errorMessage = "Oops! There's some problem."
        }
    }
    
    func goForwardForOneDay() {
        guard let updatedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate) else { return }
        selectedDate = updatedDate
    }
    
    func goBackForOneDay() {
        guard let updatedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate) else { return }
        selectedDate = updatedDate
    }
    
    
    private func convertToSmartTask(_ task: TaskModel) -> SmartTask {
        var dueDateString = "-"
        var daysLeft = "-"
        if let dueDate = task.dueDate {
            dueDateString = smartTaskFormatter.string(from: dueDate)
            daysLeft = String(Calendar.current.dateComponents([.day], from: task.targetDate, to: dueDate).day ?? 0)
        }

        return SmartTask(
            id: task.id,
            dueDate: dueDateString,
            title: task.title,
            description: task.description,
            priority: task.priority,
            comment: nil,
            status: .unresolved,
            daysLeft: daysLeft
        )
    }
    
    private func formatSelectedDate() -> String {
        if Calendar.current.isDateInToday(selectedDate) {
            return "Today"
        }
        if Calendar.current.isDateInTomorrow(selectedDate) {
            return "Tomorrow"
        }
        if Calendar.current.isDateInYesterday(selectedDate) {
            return "Yesterday"
        }
        
        let format = Date.FormatStyle()
            .day()
            .month()
        
        return selectedDate.formatted(format)
    }
}
