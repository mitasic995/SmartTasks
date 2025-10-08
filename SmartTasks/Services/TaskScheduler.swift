//
//  TaskScheduler.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import Foundation

protocol TaskScheduling {
    /// Today's date stripped from time component
    static var today: Date { get }
    
    /// Update tasks, target dates according to today's date and group them by dates
    /// - Parameter tasks: Array of `TaskModel`that needs to be scheduled
    /// - Returns: Dictionary  of taks grouped by tasks's target date
    static func scheduleTasks(_ tasks: [TaskModel]) -> [Date: [TaskModel]]
}

final class TaskScheduler: TaskScheduling {
    static var today: Date {
        stripTimeComponentsFrom(.now) ?? .now
    }
    
    static func scheduleTasks(_ tasks: [TaskModel]) -> [Date: [TaskModel]] {
        return tasks
            .compactMap { task in
                var task = task
                guard let dueDate = task.dueDate else {
                    if task.targetDate < today {
                        task.targetDate = today
                    }
                    return task
                }
                
                guard dueDate >= today else {
                    task.targetDate = dueDate
                    return task
                }

                task.targetDate = today
                return task
            }
            .reduce(into: [Date: [TaskModel]]()) { partialResult, task in
                partialResult[task.targetDate, default: []].append(task)
            }
    }
    
    private static func stripTimeComponentsFrom(_ date: Date) -> Date? {
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        
        return calendar.date(
            from: DateComponents(
                timeZone: .gmt,
                year: components.year,
                month: components.month,
                day: components.day,
                hour: 0,
                minute: 0,
                second: 0,
                nanosecond: 0)
         )
    }
}
