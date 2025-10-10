//
//  TasksViewModel.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import Foundation
import Combine

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
    
    @Published private var schedule: [Date: [TaskModel]] = [:] 
    private let repository: TasksRepository
    private let taskScheduler: TaskScheduling.Type
    private let calendar: Calendar
    private var smartTaskFormatter: DateFormatter
    private var cancellable = Set<AnyCancellable>()
    
    init(repository: TasksRepository, taskScheduler: TaskScheduling.Type) {
        self.selectedDate = TaskScheduler.today
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = .gmt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        self.smartTaskFormatter = formatter
        
        self.calendar = calendar
        self.repository = repository
        self.taskScheduler = taskScheduler
        
        $schedule
            .dropFirst()
            .sink { [weak self] updatedSchedule in
                guard let self else { return }
                let tasks = updatedSchedule[self.selectedDate] ?? []
                self.smartTasks = tasks.compactMap { model in
                    self.convertToSmartTask(model)
                }
            }
            .store(in: &cancellable)
    }
    
    func fetchTasks() async {
        do {
            let fetchedTasks  = try await repository.fetchTasks().sorted()
            self.schedule = taskScheduler.scheduleTasks(fetchedTasks, forToday: Date.now)
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
            daysLeft = String(calendar.dateComponents([.day], from: task.targetDate, to: dueDate).day ?? 0)
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
